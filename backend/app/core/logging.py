"""
Logging
=======
Centralised logging setup for the API.
"""

import logging
import os

os.makedirs("logs", exist_ok=True)

def setup_logging():
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s [%(levelname)s] %(name)s - %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
        handlers=[
            logging.FileHandler("logs/api.log"),
            logging.StreamHandler()
        ]
    )

logger = logging.getLogger("obrail")