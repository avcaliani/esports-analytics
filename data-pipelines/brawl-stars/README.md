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

☃️ Before executing the pipeline you have to create a BigQuery resource.  

```bash
make create-resource
```

🧰 Executing the pipeline **locally**.  

```bash
make download run
```

**Other commands** available for this project

```bash
# Show files from our data lake.
make show-files
```

## References

- [GCloud - App Credentials](https://cloud.google.com/docs/authentication/application-default-credentials)
- [GCloud - Cloud Storage Connector](https://cloud.google.com/dataproc/docs/concepts/connectors/cloud-storage)
- [GCloud - Spark + BigQuery](https://cloud.google.com/dataproc/docs/tutorials/bigquery-connector-spark-example)
- [GCloud - Dataproc Serverless](https://cloud.google.com/dataproc-serverless/docs/quickstarts/spark-batch)
- [Medium - Cloud Storage + Spark](https://junjiejiang94.medium.com/3-easy-step-to-use-google-storage-with-pyspark-fd053d1bde9)
- [Medium - Cloud Storage + Spark Local](https://kashif-sohail.medium.com/read-files-from-google-cloud-storage-bucket-using-local-pyspark-and-jupyter-notebooks-f8bd43f4b42e)
- [Stack Overflow - How to fix No FS for "gs" in pyspark?](https://stackoverflow.com/a/55599599)
