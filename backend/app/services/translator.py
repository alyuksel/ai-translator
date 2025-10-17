"""Translator service placeholder.

This module will later host the integration with the AI model provider. For now, it
returns a mocked translation that reflects the structure expected by the API.
"""

from ..schemas import DetailLevel, Tone, TranslationRequest, TranslationResponse, TranslationSegment


async def translate_text(request: TranslationRequest) -> TranslationResponse:
    """Mock translation service.

    In the MVP stage we return a simple deterministic response so that the frontend
    can already consume the API. Later, this function will call the AI provider
    to generate a personalised translation.
    """

    if not request.text.strip():
        raise ValueError("Text to translate cannot be empty.")

    detail_hint = _detail_description(request.detail_level)
    tone_hint = _tone_description(request.tone)

    translated = (
        f"[Mock translation to {request.target_language}] {request.text}"
        f"\n- Tone preference: {tone_hint}"
        f"\n- Detail level: {detail_hint}"
    )

    segments: list[TranslationSegment] = []

    if request.include_examples:
        segments.append(
            TranslationSegment(
                title="Example usage",
                content=(
                    "• Example 1: This is a placeholder example demonstrating how the"
                    " translated sentence could be used."
                ),
            )
        )
        segments.append(
            TranslationSegment(
                title="Cultural note",
                content=(
                    "This is where cultural or contextual notes provided by the AI would go."
                ),
            )
        )

    return TranslationResponse(
        translation=translated,
        segments=segments,
        source_language=request.source_language,
        target_language=request.target_language,
    )


def _detail_description(detail_level: DetailLevel | None) -> str:
    match detail_level:
        case DetailLevel.SUMMARY:
            return "summary"
        case DetailLevel.DETAILED:
            return "detailed"
        case DetailLevel.STANDARD | None:
            return "standard"
        case _:
            return detail_level.value  # pragma: no cover - future proofing


def _tone_description(tone: Tone | None) -> str:
    match tone:
        case Tone.SIMPLE:
            return "simple"
        case Tone.FORMAL:
            return "formal"
        case Tone.FRIENDLY:
            return "friendly"
        case Tone.PROFESSIONAL:
            return "professional"
        case None:
            return "not specified"
        case _:
            return tone.value  # pragma: no cover - future proofing
