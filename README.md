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
- Install a few things:
  - [Google Cloud CLI]
  - [Terraform]
  - [Poetry]

### Terraform Configuration

```bash
cd terraform \
    && terraform init \
    && terraform workspace new "<project_name>"
```

> 💡 More Terraform commands in [this](https://gist.github.com/avcaliani/4a68c1fdfe5132288ebea1819bdfa23f) tutorial.

## References

- 🪐 **Google Cloud**
  - [CLI - Initialization Guide](https://cloud.google.com/sdk/docs/initializing)
  - [CLI - Application Default Credentials](https://cloud.google.com/docs/authentication/application-default-credentials)

[Google Cloud CLI]: https://cloud.google.com/sdk/docs/install
[Terraform]: https://developer.hashicorp.com/terraform/downloads?product_intent=terraform
[Poetry]: https://python-poetry.org/
