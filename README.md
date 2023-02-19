# 🎮 e-Sports Analytics

![#](https://img.shields.io/badge/licence-MIT-lightseagreen.svg?logo=apache)

## Summary

- [About](#about)
- [How did I do it?](#how-did-i-do-it)
  - [Prerequisites](#prerequisites)
  - [Terraform Configuration](#terraform-configuration)
- [References](#references)

## About

```bash
TODO: Include a description here!  
TODO: Add the project architecture here!
TODO: Add Sandbox Link!
```

## How did I do it?

In this section you will find everything I did to up this project to Google Cloud.

### Prerequisites

> 💡 `<project_name>` is your Google Cloud project name/id.

- Create an account in Google Cloud
- Create two buckets:
  - `<project_name>-lake` 👉 Bucket to be your data lake.
  - `<project_name>-terraform` 👉 Bucket to store Terraform state.
- Enable some Google APIs _(Terraform will request your action to do that)_
- Install a few things:
  - [Google Cloud CLI]
  - [Terraform]
  - [Poetry]

### Copy Function Code to GCloud Bucket

```bash
cd web-crawlers/brawl-stars \
    && make deploy
```

> 💡 More details in function [README](web-crawlers/brawl-stars/README.md).

### Terraform Configuration

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

Finally, you can **delete** every resource created using Terraform.

```bash
terraform destroy
```

> 💡 More Terraform commands in [this](https://gist.github.com/avcaliani/4a68c1fdfe5132288ebea1819bdfa23f) tutorial.

## References

- 🪐 **Google Cloud**
  - [CLI - Initialization Guide](https://cloud.google.com/sdk/docs/initializing)
  - [CLI - Application Default Credentials](https://cloud.google.com/docs/authentication/application-default-credentials)

- 🌱 **Terraform**
  - [How to trigger a Cloud Function with Cloud Scheduler?](https://medium.com/geekculture/setup-gcp-cloud-functions-triggering-by-cloud-schedulers-with-terraform-1433fbf1abbe)
  - [How to create static outbund IP for Cloud Functions?](https://shashwotrisal.medium.com/how-to-create-a-static-outbound-ip-for-google-cloud-functions-using-terraform-a8e9b30074b6)
  - [How to use Secrets in Cloud Functions?](https://www.cloudreach.com/en/technical-blog/utilizing-gcp-secret-manager-secrets-in-cloud-functions-with-terraform/)

[Google Cloud CLI]: https://cloud.google.com/sdk/docs/install
[Terraform]: https://developer.hashicorp.com/terraform/downloads?product_intent=terraform
[Poetry]: https://python-poetry.org/
