// Terraform Variables
locals {
  project_id            = terraform.workspace
  functions_bucket      = "nth-analytics-lake"
  functions_bucket_path = "cloud-functions"
}

// The following variables are request at terraform "apply" as input variables.
variable "gcloud_region" {
  type    = string
  default = "us-east1"
}

variable "lake_bucket" {
  type    = string
  default = "nth-analytics-lake"
}
