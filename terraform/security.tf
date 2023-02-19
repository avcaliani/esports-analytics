// Service Account
resource "google_service_account" "supercell_sa" {
  account_id  = "supercell-service-account"
  description = "Service Account for Supercell resources."
}

// Secrets
resource "google_secret_manager_secret" "supercell_bstars_secret" {
  secret_id = "supercell-brawl-stars-secret"
  replication {
    user_managed {
      replicas { location = var.gcloud_region }
    }
  }
}

resource "google_secret_manager_secret_version" "supercell_bstars_secret_version" {
  secret      = google_secret_manager_secret.supercell_bstars_secret.id
  secret_data = "Initial value. Please, replace it before using."
}

// IAM
resource "google_secret_manager_secret_iam_binding" "supercell_bstars_secret_bind_sa" {
  project   = local.project_id
  secret_id = google_secret_manager_secret.supercell_bstars_secret.secret_id
  role      = "roles/secretmanager.secretAccessor"
  members = [
    "serviceAccount:${google_service_account.supercell_sa.email}",
  ]
}

resource "google_project_iam_member" "supercell_sa_role_bucket" {
  project = local.project_id
  member  = "serviceAccount:${google_service_account.supercell_sa.email}"
  role    = "roles/editor"
}

resource "google_project_iam_member" "supercell_sa_role_secret" {
  project = local.project_id
  member  = "serviceAccount:${google_service_account.supercell_sa.email}"
  role    = "roles/secretmanager.secretAccessor"

  condition {
    title       = "restricted_to_secret"
    description = "Allows access only to the desired secret"
    expression  = "resource.name.startsWith(\"${google_secret_manager_secret.supercell_bstars_secret.name}\")"
  }
}
