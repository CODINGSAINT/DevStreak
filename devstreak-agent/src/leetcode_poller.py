import logging

import requests

from config import USER_ID
from models import ActivityEvent

LOGGER = logging.getLogger(__name__)
LEETCODE_API = "https://leetcode.com/graphql"


class LeetCodePoller:
    def __init__(self, sender, username: str):
        self.sender = sender
        self.username = username
        self.last_total = None

    def poll_once(self):
        query = {
            "query": "query getUser($username: String!) { matchedUser(username: $username) { submitStatsGlobal { acSubmissionNum { difficulty count } } } }",
            "variables": {"username": self.username},
        }

        try:
            resp = requests.post(LEETCODE_API, json=query, timeout=8)
            resp.raise_for_status()
            data = resp.json()
            total = data["data"]["matchedUser"]["submitStatsGlobal"]["acSubmissionNum"][0]["count"]
        except Exception as exc:
            LOGGER.warning("LeetCode poll failed: %s", exc)
            return

        if self.last_total is None:
            self.last_total = total
            return

        if total > self.last_total:
            solved = total - self.last_total
            self.sender.send(
                ActivityEvent.now(
                    USER_ID,
                    "LEETCODE_SOLVED",
                    {"username": self.username, "count": solved},
                )
            )
        self.last_total = total
