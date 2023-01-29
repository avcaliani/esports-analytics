from datetime import datetime
from functools import reduce
from typing import List

from google.cloud.storage import Client


def now():
    """Return current timestamp as string.

    Returns:
        str: Current Timestamp.
    """
    return datetime.utcnow().strftime("%Y%m%d_%H%M%S")


def write(bucket: str, file_prefix: str, data: List[str]) -> str:
    """Write a list of strings to a file in Cloud Storage.

    Args:
        bucket (str): Bucket Name.
        file_prefix (str): File Prefix.
        data (List[str]): File Content.

    Returns:
        str: Saved file name.
    """
    data = reduce(lambda x, y: f"{x}\n{y}", data)
    file_name = f"{file_prefix}_{now()}.json"
    Client() \
        .get_bucket(bucket) \
        .blob(file_name) \
        .upload_from_string(data)
    return f"gs://{bucket}/{file_name}"
