output "project_id" {
  description = "🦉 Project Name"
  value       = local.project_id
}

output "gcloud_region" {
  description = "🌎 GCloud Region"
  value       = var.gcloud_region
}

output "static_ip" {
  description = "📟 Static IP Address"
  value       = google_compute_address.supercell_static_ip.address
}

output "spark_temp_bucket" {
  description = "💥 Spark Temporary Bucket"
  value       = google_storage_bucket.spark_bq_temp_bucket.name
}
