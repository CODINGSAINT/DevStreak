from dataclasses import dataclass, asdict
from datetime import datetime, timezone
from typing import Dict, Any


@dataclass
class ActivityEvent:
    userId: str
    eventType: str
    metadata: Dict[str, Any]
    timestamp: str

    @staticmethod
    def now(user_id: str, event_type: str, metadata: Dict[str, Any]) -> "ActivityEvent":
        ts = datetime.now(timezone.utc).replace(microsecond=0).isoformat()
        return ActivityEvent(userId=user_id, eventType=event_type, metadata=metadata, timestamp=ts)

    def to_json(self) -> Dict[str, Any]:
        return asdict(self)
