"""
Dependencies
============
Shared FastAPI dependencies injected into endpoints.
"""

from typing import Generator
from sqlalchemy.orm import Session
from app.db.session import SessionLocal


def get_db() -> Generator:
    """
    Yields a database session and closes it after the request.
    Used in endpoints: db: Session = Depends(get_db)
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()