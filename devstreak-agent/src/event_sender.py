import logging
import requests

from config import BACKEND_URL
from models import ActivityEvent

LOGGER = logging.getLogger(__name__)


class EventSender:
    def __init__(self, backend_url: str = BACKEND_URL):
        self.backend_url = backend_url.rstrip("/")

    def send(self, event: ActivityEvent) -> None:
        url = f"{self.backend_url}/events"
        try:
            response = requests.post(url, json=event.to_json(), timeout=5)
            response.raise_for_status()
            LOGGER.info("Event sent: %s", event.eventType)
        except requests.RequestException as exc:
            LOGGER.warning("Failed to send event %s: %s", event.eventType, exc)
