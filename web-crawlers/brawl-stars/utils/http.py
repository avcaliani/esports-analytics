import json
from datetime import datetime
from typing import Dict, Optional

import requests


def get_data(url: str, headers: Dict[str, str]) -> Optional[str]:
    """GET HTTP Request to URL using custom Headers.

    Args:
        url (str): API URL.
        headers (Dict[str, str]): API Headers.

    Returns:
        Optional[str]: API Response as JSON string or None.
    """
    resp = requests.get(url, headers=headers)
    if resp.status_code == 200:
        data = resp.json()
        data["extracted_at"] = datetime.utcnow()
        return json.dumps(data, ensure_ascii=False, default=str)
    
    print("---< Error >---")
    print(f"URL: {url}")
    print(f"Status Code: {resp.status_code}")
    print(f"Content: {resp.content}")
    return None
