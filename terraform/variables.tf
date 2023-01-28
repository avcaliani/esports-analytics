// Terraform Variables
locals {
  project_name = terraform.workspace
}

// The following variables are request at terraform "apply" as input variables.
variable "gcloud_region" {
  type    = string
  default = "us-east1"
}
