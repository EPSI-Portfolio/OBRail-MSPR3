"""
Configuration
=============
App settings loaded from environment variables.
All sensitive values are read from .env and never hardcoded.
"""

import os
from dotenv import load_dotenv

load_dotenv()

class Settings:
    # App
    APP_NAME: str    = "ObRail Europe API"
    APP_VERSION: str = "2.0.0"

    # Environment — development or production.
    # Change to production when deploying to a real server.
    ENVIRONMENT: str = os.getenv("ENVIRONMENT", "development")

    @property
    def is_production(self) -> bool:
        return self.ENVIRONMENT == "production"

    # Debug mode — only active in development.
    @property
    def DEBUG(self) -> bool:
        return not self.is_production and os.getenv("DEBUG", "false").lower() == "true"

    # Database — all values from environment, no sensitive defaults.
    POSTGRES_USER: str     = os.getenv("POSTGRES_USER") or ""
    POSTGRES_PASSWORD: str = os.getenv("POSTGRES_PASSWORD") or ""
    POSTGRES_HOST: str     = os.getenv("POSTGRES_HOST") or "localhost"
    POSTGRES_PORT: str     = os.getenv("POSTGRES_PORT") or "5434"
    POSTGRES_DB: str       = os.getenv("POSTGRES_DB") or ""

    @property
    def DATABASE_URL(self) -> str:
        return (
            f"postgresql://{self.POSTGRES_USER}:{self.POSTGRES_PASSWORD}"
            f"@{self.POSTGRES_HOST}:{self.POSTGRES_PORT}/{self.POSTGRES_DB}"
        )

    # API
    API_PREFIX: str = "/api/v1"

    # CORS — allows all origins in development.
    # When you have a real frontend domain, set CORS_ORIGINS in .env.
    @property
    def CORS_ORIGINS(self) -> list:
        origins = os.getenv("CORS_ORIGINS", "")
        if origins:
            return [o.strip() for o in origins.split(",") if o.strip()]
        return ["*"]

    # Pagination
    DEFAULT_LIMIT: int = 50
    MAX_LIMIT: int     = 500

    # API key authentication — loaded from environment.
    # If empty, all requests are allowed (development only).
    API_KEY: str = os.getenv("API_KEY", "")


settings = Settings()