"""
Security
========
Basic API key authentication.
Set API_KEY in .env to enable protection.
Leave empty to allow public access (default for development).
"""

import os
from fastapi import Security, HTTPException, status
from fastapi.security.api_key import APIKeyHeader

API_KEY        = os.getenv("API_KEY", "")
API_KEY_HEADER = APIKeyHeader(name="X-API-Key", auto_error=False)


async def verify_api_key(api_key: str = Security(API_KEY_HEADER)):
    """
    Validates API key if one is configured.
    If no API_KEY is set in .env, all requests are allowed.
    """
    if not API_KEY:
        return
    if api_key != API_KEY:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Invalid or missing API key"
        )