"""
Configuration
=============
App settings loaded from environment variables.
"""

import os
from dotenv import load_dotenv

load_dotenv()

class Settings:
    # App
    APP_NAME: str = "ObRail Europe API"
    APP_VERSION: str = "2.0.0"
    DEBUG: bool = os.getenv("DEBUG", "false").lower() == "true"

    # Database
    POSTGRES_USER: str     = os.getenv("POSTGRES_USER", "obrail_user")
    POSTGRES_PASSWORD: str = os.getenv("POSTGRES_PASSWORD", "password")
    POSTGRES_HOST: str     = os.getenv("POSTGRES_HOST", "localhost")
    POSTGRES_PORT: str     = os.getenv("POSTGRES_PORT", "5433")
    POSTGRES_DB: str       = os.getenv("POSTGRES_DB", "obrail_db")

    @property
    def DATABASE_URL(self) -> str:
        return (
            f"postgresql://{self.POSTGRES_USER}:{self.POSTGRES_PASSWORD}"
            f"@{self.POSTGRES_HOST}:{self.POSTGRES_PORT}/{self.POSTGRES_DB}"
        )

    # API
    API_PREFIX: str  = "/api/v1"
    CORS_ORIGINS: list = ["*"]

    # Pagination
    DEFAULT_LIMIT: int = 50
    MAX_LIMIT: int     = 500


settings = Settings()