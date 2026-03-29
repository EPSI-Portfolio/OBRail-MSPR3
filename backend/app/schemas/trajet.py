"""
Schemas
=======
Pydantic models for request/response validation.
FastAPI uses these for automatic docs and input validation.
"""

from pydantic import BaseModel
from typing import Optional
from datetime import date


class TrajetBase(BaseModel):
    """Full route with all fields — used for /trajets/{id}"""
    route_id: int
    route_name: Optional[str]
    route_name_simple: Optional[str]
    origin: str
    destination: str
    origin_country: Optional[str]
    destination_country: Optional[str]
    distance_km: Optional[float]
    service_type: Optional[str]
    train_type: Optional[str]
    operator: Optional[str]
    train_gco2_pkm: Optional[float]
    plane_gco2_pkm: Optional[float]
    train_co2_kg: Optional[float]
    plane_co2_kg: Optional[float]
    co2_savings_kg: Optional[float]
    savings_percent: Optional[float]
    emission_source: Optional[str]
    calculation_date: Optional[date]

    class Config:
        from_attributes = True


class TrajetSummary(BaseModel):
    """Lightweight route for list views — used for /trajets"""
    route_id: int
    route_name_simple: Optional[str]
    origin: str
    destination: str
    origin_country: Optional[str]
    destination_country: Optional[str]
    distance_km: Optional[float]
    service_type: Optional[str]
    operator: Optional[str]
    co2_savings_kg: Optional[float]
    savings_percent: Optional[float]

    class Config:
        from_attributes = True


class TrajetsResponse(BaseModel):
    """Paginated response for /trajets"""
    total: int
    limit: int
    offset: int
    trajets: list[TrajetSummary]


class VolumeStats(BaseModel):
    """Day/night volume by country — used for /stats/volumes"""
    origin_country: str
    service_type: str
    route_count: int
    avg_distance_km: Optional[float]


class VolumeStatsResponse(BaseModel):
    """Response for /stats/volumes"""
    total: int
    data: list[VolumeStats]


class Co2Stats(BaseModel):
    """CO2 savings by country"""
    origin_country: str
    route_count: int
    total_savings_kg: Optional[float]
    avg_savings_per_route_kg: Optional[float]
    total_savings_tons: Optional[float]


class Co2StatsResponse(BaseModel):
    """Response for /stats/co2"""
    total_routes: int
    total_co2_saved_kg: Optional[float]
    total_co2_saved_tons: Optional[float]
    avg_savings_percent: Optional[float]
    by_country: list[Co2Stats]