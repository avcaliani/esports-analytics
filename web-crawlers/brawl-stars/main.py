from os import environ
from typing import Optional

from flask import Request, jsonify
from utils import cloud, http

API_URL = "https://api.brawlstars.com"
API_HEADERS = {
    "Accept": "application/json",
    "Authorization": f"Bearer {environ.get('API_TOKEN')}"
}

PLAYERS = [
    "#8U098L8",  # me
    "#8GGQG8YQ",
    "#2G8LVJU2Y",
    "#PU8G9VCV",
    "#PLYU9GLP",
]


def get_player_data() -> list:
    responses = []
    for player in PLAYERS:
        player_id = player.replace("#", "%23")
        response = http.get_data(
            f"{API_URL}/v1/players/{player_id}", API_HEADERS)
        if response:
            responses.append(response)
    return responses


def write_file(responses: list) -> Optional[str]:
    if not responses:
        return None
    return cloud.write(
        bucket="nth-analytics-lake",
        file_prefix="raw/brawl-stars/players/players",
        data=responses
    )


def main(request: Request):
    print("Starting... 🛫")
    responses = get_player_data()

    print(f"Saving {len(responses)} records... 💾")
    saved_file = write_file(responses)

    print("The End ✅")
    return jsonify({
        "players": len(PLAYERS),
        "responses": len(responses),
        "saved_file": saved_file
    })
