"""
Logging
=======
Centralised, structured (JSON) logging for the API.

Every log line is a single JSON object so it can be parsed reliably by
Promtail and queried in Grafana/Loki. Logs are written both to stdout
(for `docker logs`) and to logs/api.log (tailed by Promtail).
"""

import datetime
import json
import logging
import os

os.makedirs("logs", exist_ok=True)


class JsonFormatter(logging.Formatter):
    """Formats each log record as a one-line JSON object."""

    def format(self, record: logging.LogRecord) -> str:
        payload = {
            "timestamp": datetime.datetime.utcfromtimestamp(record.created).isoformat() + "Z",
            "level": record.levelname,
            "logger": record.name,
            "message": record.getMessage(),
        }
        if record.exc_info:
            payload["exception"] = self.formatException(record.exc_info)
        return json.dumps(payload, ensure_ascii=False)


def setup_logging():
    formatter = JsonFormatter()

    file_handler = logging.FileHandler("logs/api.log")
    file_handler.setFormatter(formatter)

    stream_handler = logging.StreamHandler()
    stream_handler.setFormatter(formatter)

    root = logging.getLogger()
    root.setLevel(logging.INFO)
    root.handlers = [file_handler, stream_handler]


logger = logging.getLogger("obrail")
