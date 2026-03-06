import logging
import time

import schedule

from config import GIT_ROOT, LEETCODE_POLL_MINUTES, LEETCODE_USERNAME, PROCESS_SCAN_SECONDS
from event_sender import EventSender
from git_watcher import GitWatcher
from leetcode_poller import LeetCodePoller
from process_detector import ProcessDetector

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")


def run():
    sender = EventSender()
    process_detector = ProcessDetector(sender)
    git_watcher = GitWatcher(sender, GIT_ROOT)
    leetcode_poller = LeetCodePoller(sender, LEETCODE_USERNAME)

    git_watcher.start()

    schedule.every(PROCESS_SCAN_SECONDS).seconds.do(process_detector.scan_once)
    schedule.every(LEETCODE_POLL_MINUTES).minutes.do(leetcode_poller.poll_once)

    process_detector.scan_once()
    leetcode_poller.poll_once()

    try:
        while True:
            schedule.run_pending()
            time.sleep(1)
    except KeyboardInterrupt:
        git_watcher.stop()


if __name__ == "__main__":
    run()
