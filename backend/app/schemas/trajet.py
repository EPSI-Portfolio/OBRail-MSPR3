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
    route_name: Optional[str] = None
    route_name_simple: Optional[str] = None
    origin: str
    destination: str
    origin_country: Optional[str] = None
    destination_country: Optional[str] = None
    distance_km: Optional[float] = None
    service_type: Optional[str] = None
    train_type: Optional[str] = None
    operator: Optional[str] = None
    train_gco2_pkm: Optional[float] = None
    plane_gco2_pkm: Optional[float] = None
    train_co2_kg: Optional[float] = None
    plane_co2_kg: Optional[float] = None
    co2_savings_kg: Optional[float] = None
    savings_percent: Optional[float] = None
    emission_source: Optional[str] = None
    calculation_date: Optional[date] = None
    duration_minutes: Optional[int] = None

    class Config:
        from_attributes = True


class TrajetSummary(BaseModel):
    """Lightweight route for list views — used for /trajets"""
    route_id: int
    route_name_simple: Optional[str] = None
    origin: str
    destination: str
    origin_country: Optional[str] = None
    destination_country: Optional[str] = None
    distance_km: Optional[float] = None
    service_type: Optional[str] = None
    operator: Optional[str] = None
    co2_savings_kg: Optional[float] = None
    savings_percent: Optional[float] = None
    duration_minutes: Optional[int] = None

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
    avg_distance_km: Optional[float] = None


class VolumeStatsResponse(BaseModel):
    """Response for /stats/volumes"""
    total: int
    data: list[VolumeStats]


class OperatorStats(BaseModel):
    """Routes and CO2 savings by operator"""
    operator: Optional[str] = None
    route_count: int
    avg_co2_savings_kg: Optional[float] = None
    total_co2_savings_kg: Optional[float] = None


class Co2Stats(BaseModel):
    """CO2 savings by country"""
    origin_country: str
    route_count: int
    total_savings_kg: Optional[float] = None
    avg_savings_per_route_kg: Optional[float] = None
    total_savings_tons: Optional[float] = None


class Co2StatsResponse(BaseModel):
    """Response for /stats/co2"""
    total_routes: int
    total_co2_saved_kg: Optional[float] = None
    total_co2_saved_tons: Optional[float] = None
    avg_savings_percent: Optional[float] = None
    by_country: list[Co2Stats]


class StatsVolumesResponse(BaseModel):
    """Combined response for /stats/volumes"""
    day_night_split: list[VolumeStats]
    by_operator: list[OperatorStats]