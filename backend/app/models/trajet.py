"""
Trajet Model
============
SQLAlchemy ORM model mapping to the fact_routes table.
Mirrors the schema defined in database/init/01_create_schema.sql
"""

from sqlalchemy import Column, Integer, String, Float, Date, DateTime
from sqlalchemy.sql import func
from app.db.base import Base


class Trajet(Base):
    __tablename__ = "fact_routes"

    route_id            = Column(Integer, primary_key=True, index=True)
    route_name          = Column(String(200))
    route_name_simple   = Column(String(200))
    origin              = Column(String(100), nullable=False)
    destination         = Column(String(100), nullable=False)
    origin_country      = Column(String(5))
    destination_country = Column(String(5))
    distance_km         = Column(Float)
    service_type        = Column(String(20))
    train_type          = Column(String(20))
    operator            = Column(String(100))
    train_gco2_pkm      = Column(Float)
    plane_gco2_pkm      = Column(Float)
    train_co2_kg        = Column(Float)
    plane_co2_kg        = Column(Float)
    co2_savings_kg      = Column(Float)
    savings_percent     = Column(Float)
    emission_source     = Column(String(100))
    calculation_date    = Column(Date)
    created_at          = Column(DateTime, server_default=func.now())
    duration_minutes    = Column(Integer)