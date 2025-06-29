# Cloud Run Outputs
output "service_name" {
  value = google_cloud_run_service.default.name
}
output "service_url" {
  value = google_cloud_run_service.default.status[0].url
}
