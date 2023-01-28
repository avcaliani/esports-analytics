from datetime import datetime

from flask import Request, jsonify


def main(request: Request):
    """HTTP Cloud Function.
    Args:
        request (Request): The request object.
    Returns:
        JSON with processed data summary.
    """
    debug = request.args.get(key="debug", default=False, type=bool)
    return jsonify({
        "user": request.args.get("name", "no name"),
        "now": "debug-time" if debug else datetime.now(),
    })
