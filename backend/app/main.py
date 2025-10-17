from fastapi import FastAPI, HTTPException

from .schemas import TranslationRequest, TranslationResponse
from .services.translator import translate_text

app = FastAPI(
    title="AI Translator API",
    description=(
        "Backend API for the AI-powered translation application. "
        "It adapts translations based on user preferences such as tone, detail level, and examples."
    ),
    version="0.1.0",
)


@app.get("/health", tags=["Health"])
def health_check() -> dict[str, str]:
    """Simple health-check endpoint."""
    return {"status": "ok"}


@app.post("/translate", response_model=TranslationResponse, tags=["Translation"])
async def translate(request: TranslationRequest) -> TranslationResponse:
    """Translate text according to the user's preferences."""
    try:
        translation_result = await translate_text(request)
    except ValueError as exc:  # pragma: no cover - defensive, not yet covered by tests
        raise HTTPException(status_code=400, detail=str(exc)) from exc

    return translation_result
