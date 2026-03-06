import logging
from pathlib import Path

from watchdog.events import FileSystemEventHandler
from watchdog.observers import Observer

from config import USER_ID
from models import ActivityEvent

LOGGER = logging.getLogger(__name__)


class GitHeadLogHandler(FileSystemEventHandler):
    def __init__(self, sender, repo_root: Path):
        super().__init__()
        self.sender = sender
        self.repo_root = repo_root

    def on_modified(self, event):
        path = Path(event.src_path)
        if path.as_posix().endswith(".git/logs/HEAD"):
            self.sender.send(
                ActivityEvent.now(
                    USER_ID,
                    "GIT_COMMIT",
                    {
                        "repo": self.repo_root.name,
                        "branch": self._read_branch(),
                    },
                )
            )

    def _read_branch(self) -> str:
        head_file = self.repo_root / ".git" / "HEAD"
        try:
            ref = head_file.read_text(encoding="utf-8").strip()
            if ref.startswith("ref:"):
                return ref.split("/")[-1]
            return "detached"
        except OSError:
            return "unknown"


class GitWatcher:
    def __init__(self, sender, repo_root: str):
        self.sender = sender
        self.repo_root = Path(repo_root)
        self.observer = Observer()

    def start(self):
        git_dir = self.repo_root / ".git"
        if not git_dir.exists():
            LOGGER.warning("No .git directory found at %s", self.repo_root)
            return

        handler = GitHeadLogHandler(self.sender, self.repo_root)
        self.observer.schedule(handler, str(git_dir / "logs"), recursive=False)
        self.observer.start()
        LOGGER.info("Started git watcher at %s", git_dir)

    def stop(self):
        if self.observer.is_alive():
            self.observer.stop()
            self.observer.join(timeout=3)
