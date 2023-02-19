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
