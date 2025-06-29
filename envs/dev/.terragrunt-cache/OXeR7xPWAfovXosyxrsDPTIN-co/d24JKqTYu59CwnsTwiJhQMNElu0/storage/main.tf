# Storage Module
# Creates a GCS bucket for logs

resource "google_storage_bucket" "logs" {
  name     = "resource-tracker-logs-sairam-${var.project_id}"
  project  = var.project_id
  location = "US"
  force_destroy = true
}
