terraform {

  backend "gcs" {
    bucket = "nth-analytics-terraform"
    prefix = "projects/esports-analytics/state"
  }

  required_providers {
    // https://registry.terraform.io/providers/hashicorp/google/latest/docs
    google = {
      source  = "hashicorp/google"
      version = "4.50.0"
    }
  }

  required_version = ">= 1.3.7"
}

provider "google" {
  project = local.project_id
  region  = var.gcloud_region
}
