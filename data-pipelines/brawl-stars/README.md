# ⚙️ Data Pipeline - Brawl Stars

![#](https://img.shields.io/badge/python-3.10.6-blue.svg?logo=python&logoColor=white)
![#](https://img.shields.io/badge/apache--spark-3.3.x-orange.svg?logo=apache-spark&logoColor=white)

## 🛫 Quick Start

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

🧰 Executing the pipeline **locally**.  

```bash
make download local
```

## 🚀 Deploy

To deploy the cloud function, execute...

```bash
# Soon...
```

## References

- [GCloud - App Credentials](https://cloud.google.com/docs/authentication/application-default-credentials)
