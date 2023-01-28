# 🕷 Web Crawler - Brawl Stars

![#](https://img.shields.io/badge/python-3.10.6-blue.svg?logo=python&logoColor=white)

## Quick Start

```bash
# 👇 Setting PyEnv version
pyenv local 3.10.6

# 👇 Virtual Environment
python -m venv .venv \
  && source .venv/bin/activate \
  && python -m pip install --upgrade pip

# 👇 Dependencies
poetry install
```

### Executing Locally

```bash
make local
```

### Deploy

```bash
make deploy
```

### Deleting Function

```bash
make destroy
```

### References

- [GCloud - Cloud Function in Python](https://codelabs.developers.google.com/codelabs/cloud-functions-python-http)
- [Brawl Stars - Developer Docs](https://developer.brawlstars.com)
- Articles
  - [Cloud Functions Best Practices](https://medium.com/google-cloud/cloud-functions-best-practices-1-4-get-the-environment-ready-af666af89f62)
