# Cloud Scheduler Module
# Schedules a daily job to publish to Pub/Sub

resource "google_cloud_scheduler_job" "job" {
  name             = "resource-tracker-job"
  project          = var.project_id
  region           = var.region
  schedule         = "0 7 * * *"
  time_zone        = "Etc/UTC"
  pubsub_target {
    topic_name = "projects/${var.project_id}/topics/${var.topic_name}"
    data       = base64encode("{\"message\": \"trigger\"}")
  }
}
