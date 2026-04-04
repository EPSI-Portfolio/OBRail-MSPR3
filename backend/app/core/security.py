"""
Security
========
API key authentication and security utilities.
API_KEY — protects all API endpoints via X-API-Key header.
SECRET_KEY — used for signing security logs and internal tokens.
Set both in .env. Leave API_KEY empty to allow public access in development.
"""

import os
import hmac
import hashlib
import logging
from fastapi import Security, HTTPException, status
from fastapi.security.api_key import APIKeyHeader

API_KEY        = os.getenv("API_KEY", "")
SECRET_KEY     = os.getenv("SECRET_KEY", "")
API_KEY_HEADER = APIKeyHeader(name="X-API-Key", auto_error=False)

logger = logging.getLogger("obrail")


def sign_message(message: str) -> str:
    """Creates an HMAC signature for a message using the SECRET_KEY.
    Used to verify the integrity of internal data."""
    if not SECRET_KEY:
        return ""
    return hmac.new(
        SECRET_KEY.encode(),
        message.encode(),
        hashlib.sha256
    ).hexdigest()


async def verify_api_key(api_key: str = Security(API_KEY_HEADER)):
    """Validates the API key on every request.
    If no API_KEY is configured, all requests are allowed (development mode).
    Failed attempts are logged with a signed fingerprint for audit purposes.
    """
    if not API_KEY:
        return

    if api_key != API_KEY:
        # Sign the rejection event for audit log integrity.
        fingerprint = sign_message(f"rejected:{api_key or 'no-key'}")
        logger.warning(
            f"Unauthorized API access attempt — fingerprint: {fingerprint[:16]}..."
        )
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Invalid or missing API key"
        )

    logger.debug("API key verified successfully")