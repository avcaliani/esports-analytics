# 🎮 e-Sports Analytics

![#](https://img.shields.io/badge/licence-MIT-lightseagreen.svg?logo=apache)

## Summary

- [About](#about)
- [Hands On](#hands-on)
  - [Prerequisites](#prerequisites)
  - [CLI Authentication](#cli-authentication)
  - [Cloud Function](#cloud-function)
  - [Terraform Configuration](#terraform-configuration)
  - [Data Pipeline](#data-pipeline)
  - [Deleting Resources](#deleting-resources)
- [References](#references)

## About

```bash
TODO: Include a description here!  
TODO: Add the project architecture here!
TODO: Add Sandbox Link!
```

## Hands On

In this section you will find everything I did to up and execute this project.

### Prerequisites

> 💡 `<project_name>` is your Google Cloud project name/id.

- Create an account in Google Cloud
- Create two buckets mannualy:
  - `<project_name>-lake` 👉 Bucket to be your data lake.
  - `<project_name>-terraform` 👉 Bucket to store Terraform state.
- Install a few things:
  - Python
  - [Poetry]
  - [Apache Spark]
  - [Google Cloud CLI]
  - [Terraform]

> 💡 **Important Note**  
> Have in mind that my scripts are pointing to the buckets I've created, you must update them to point to your own buckets.

### CLI Authentication

After installing the [Google Cloud CLI] I've followed the "[CLI - Application Default Credentials]" guide to authenticate my terminal.

```bash
gcloud auth application-default login
```

Then, create the following variable in your terminal session or add it into your `.zshrc` / `.bashrc` file.

```bash
export GOOGLE_APPLICATION_CREDENTIALS=~/.config/gcloud/application_default_credentials.json
```

> 💡 The previous commands are **very important** to make terraform and data pipeline script work properly.

### Cloud Function

Before we create our stack in Google Cloud, we must "deploy" the Cloud function package in order to Terraform be able to create our function.  
In order to do that we are going to copy the Cloud Function code into the `<project_name>-lake` bucket you have created in the previous steps.

```bash
cd web-crawlers/brawl-stars \
    && make deploy
```

> 💡 More details about the code and scripts can be found in function [README](web-crawlers/brawl-stars/README.md).

### Terraform Configuration

Now, it's time to create our infra structure.

```bash
cd terraform \
    && terraform init \
    && terraform workspace new "<project_name>"
```

Then, check `terraform/variables.tf` and update it with the names you have given to your buckets.  
You also have to update the bucket name from `terraform > backend` configuration which is in `terraform/main.tf` file.

Now, you can **deploy** all the resources.

```bash
terraform apply
```

After creating the cloud resources using terraform, you can check logs about executions and resources in Google Cloud console.  

> 💡 More Terraform commands in [this](https://gist.github.com/avcaliani/4a68c1fdfe5132288ebea1819bdfa23f) tutorial.

### Data Pipeline

As mentioned before, the cloud function will save some data into a bucket, in order to process them we have a data pipeline.
In this project our data pipeline was developed using [Apache Spark] and the data will be saved into Big Query.

More details about the pipeline, like how to execute it, can be found in this [README](data-pipelines/brawl-stars/README.md)

### Deleting Resources

Finally, if you want to **delete** the project and all the resources create by terraform, you can simply execute...

```bash
cd terraform && terraform destroy
```

Then, delete Big Query data.

```bash
cd data-pipelines/brawl-stars && make delete-resource
```

Finally, do not forget to delete the manual buckets you have created in the beginning.

## References

- 🌎 **Google Cloud**
  - [CLI - Initialization Guide](https://cloud.google.com/sdk/docs/initializing)
  - [CLI - Application Default Credentials]

- 🌳 **Terraform**
  - [How to trigger a Cloud Function with Cloud Scheduler?](https://medium.com/geekculture/setup-gcp-cloud-functions-triggering-by-cloud-schedulers-with-terraform-1433fbf1abbe)
  - [How to create static outbund IP for Cloud Functions?](https://shashwotrisal.medium.com/how-to-create-a-static-outbound-ip-for-google-cloud-functions-using-terraform-a8e9b30074b6)
  - [How to use Secrets in Cloud Functions?](https://www.cloudreach.com/en/technical-blog/utilizing-gcp-secret-manager-secrets-in-cloud-functions-with-terraform/)
  - [How to recreate a resource using Terraform?](https://stackoverflow.com/a/70773865)

[Apache Spark]: https://spark.apache.org
[CLI - Application Default Credentials]: https://cloud.google.com/docs/authentication/application-default-credentials
[Google Cloud CLI]: https://cloud.google.com/sdk/docs/install
[Terraform]: https://developer.hashicorp.com/terraform/downloads?product_intent=terraform
[Poetry]: https://python-poetry.org/