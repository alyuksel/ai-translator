from enum import Enum
from typing import Optional

from pydantic import BaseModel, Field


class Tone(str, Enum):
    SIMPLE = "simple"
    FORMAL = "formal"
    FRIENDLY = "friendly"
    PROFESSIONAL = "professional"


class DetailLevel(str, Enum):
    SUMMARY = "summary"
    STANDARD = "standard"
    DETAILED = "detailed"


class TranslationRequest(BaseModel):
    text: str = Field(..., description="Text to translate")
    source_language: str = Field(..., description="Source language code, e.g. 'fr'")
    target_language: str = Field(..., description="Target language code, e.g. 'en'")
    tone: Optional[Tone] = Field(None, description="Preferred tone of the translation")
    detail_level: Optional[DetailLevel] = Field(
        None, description="Level of detail expected in the translation"
    )
    include_examples: bool = Field(
        default=False,
        description="Whether to include usage examples in the translation",
    )


class TranslationSegment(BaseModel):
    title: str
    content: str


class TranslationResponse(BaseModel):
    translation: str
    segments: list[TranslationSegment] = Field(
        default_factory=list,
        description="Optional structured elements such as explanations or examples.",
    )
    source_language: str
    target_language: str
