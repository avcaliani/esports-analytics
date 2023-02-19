# 🕷 Web Crawler - Brawl Stars

![#](https://img.shields.io/badge/python-3.10.6-blue.svg?logo=python&logoColor=white)

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

🧰 Executing the cloud function **locally**.  
In this project the API Token is associated with your own IP Address.  
Here it is how you can get your own IP.

```bash
echo "🌎 Current IP: $(curl -s http://ipinfo.io/ip)"
```

Then you can update [your token] using the following code...

[your token]: https://developer.brawlstars.com/#/account

```bash
export BUCKET_NAME="<your_bucket>"
export API_TOKEN="<your_token>"
```

Finally, excute the function locally.

```bash
make local
```

## 🚀 Deploy

To deploy the cloud function, execute...

```bash
make deploy
```

If you are **updating** the cloud function code, after `make deploy` you have to...

```bash
cd ../../terraform &&
  terraform apply -replace=google_cloudfunctions_function.supercell_bstars_function
```

This command will recreate the Cloud Function and then the `*.zip` reference will be updated.

## References

- [GCloud - Cloud Function in Python](https://codelabs.developers.google.com/codelabs/cloud-functions-python-http)
- [Brawl Stars - Developer Docs](https://developer.brawlstars.com)
- Articles
  - [Cloud Functions Best Practices](https://medium.com/google-cloud/cloud-functions-best-practices-1-4-get-the-environment-ready-af666af89f62)
