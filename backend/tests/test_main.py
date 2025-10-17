from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_health_endpoint() -> None:
    response = client.get("/health")

    assert response.status_code == 200
    assert response.json() == {"status": "ok"}


def test_translate_endpoint_returns_mocked_content() -> None:
    payload = {
        "text": "Bonjour tout le monde",
        "source_language": "fr",
        "target_language": "en",
        "tone": "friendly",
        "detail_level": "detailed",
        "include_examples": True,
    }

    response = client.post("/translate", json=payload)

    assert response.status_code == 200
    data = response.json()

    assert data["source_language"] == "fr"
    assert data["target_language"] == "en"
    assert data["translation"].startswith("[Mock translation to en] Bonjour tout le monde")
    assert len(data["segments"]) == 2
    assert {segment["title"] for segment in data["segments"]} == {
        "Example usage",
        "Cultural note",
    }


def test_translate_endpoint_rejects_empty_text() -> None:
    payload = {
        "text": "   ",
        "source_language": "fr",
        "target_language": "en",
    }

    response = client.post("/translate", json=payload)

    assert response.status_code == 400
    assert response.json()["detail"] == "Text to translate cannot be empty."
