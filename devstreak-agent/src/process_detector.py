import psutil

from config import USER_ID
from models import ActivityEvent


class ProcessDetector:
    IDEA_PROCESS = "idea64.exe"
    VSCODE_PROCESS = "code.exe"

    def __init__(self, sender):
        self.sender = sender

    def scan_once(self):
        running = {p.info["name"].lower() for p in psutil.process_iter(["name"]) if p.info.get("name")}

        if self.IDEA_PROCESS in running:
            self.sender.send(ActivityEvent.now(USER_ID, "INTELLIJ_ACTIVE", {"process": self.IDEA_PROCESS}))

        if self.VSCODE_PROCESS in running:
            self.sender.send(ActivityEvent.now(USER_ID, "VSCODE_ACTIVE", {"process": self.VSCODE_PROCESS}))
