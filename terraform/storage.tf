// Buckets
resource "google_storage_bucket" "spark_bq_temp_bucket" {
  name          = "nth-analytics-spark-temp"
  location      = "US-EAST1"
  force_destroy = true
  uniform_bucket_level_access = true
}