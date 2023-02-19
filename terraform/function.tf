// Cloud Scheduler
resource "google_cloud_scheduler_job" "supercell_bstars_scheduler" {
  name        = "supercell-scheduler"
  description = "Trigger cloud function twice in a day."
  schedule    = "0 */12 * * *"
  http_target {
    http_method = "GET"
    uri         = google_cloudfunctions_function.supercell_bstars_function.https_trigger_url
    oidc_token {
      service_account_email = google_service_account.supercell_sa.email
    }
  }
}

// Cloud Function
resource "google_cloudfunctions_function" "supercell_bstars_function" {

  name        = "supercell-brawl-stars-function"
  description = "Web Crawler - Supercell: Brawl Stars"
  runtime     = "python311"

  available_memory_mb          = 256
  source_archive_bucket        = local.functions_bucket
  source_archive_object        = "${local.functions_bucket_path}/brawl-stars-function.zip"
  trigger_http                 = true
  https_trigger_security_level = "SECURE_ALWAYS"
  timeout                      = 500
  entry_point                  = "main"

  vpc_connector                 = google_vpc_access_connector.supercell_vpc_connector.name
  vpc_connector_egress_settings = "ALL_TRAFFIC"

  service_account_email = google_service_account.supercell_sa.email

  secret_environment_variables {
    key     = "API_TOKEN"
    secret  = google_secret_manager_secret.supercell_bstars_secret.secret_id
    version = "latest"
  }

  environment_variables = {
    BUCKET_NAME = var.lake_bucket
  }

}

resource "google_cloudfunctions_function_iam_member" "supercell_bstars_func_invoker" {
  project        = google_cloudfunctions_function.supercell_bstars_function.project
  region         = google_cloudfunctions_function.supercell_bstars_function.region
  cloud_function = google_cloudfunctions_function.supercell_bstars_function.name
  role           = "roles/cloudfunctions.invoker"
  member         = "serviceAccount:${google_service_account.supercell_sa.email}"
}
