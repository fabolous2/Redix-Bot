from uuid import UUID
from typing import Optional, List

from pydantic import BaseModel, Field


class FeedbackProduct(BaseModel):
    id: UUID


class CreateFeedback(BaseModel):
    product: FeedbackProduct
    order_id: UUID
    stars: Optional[int] = Field(le=5, default=None)
    text: str = Field(max_length=500)
    images: Optional[List[str]] = Field(default=None)
