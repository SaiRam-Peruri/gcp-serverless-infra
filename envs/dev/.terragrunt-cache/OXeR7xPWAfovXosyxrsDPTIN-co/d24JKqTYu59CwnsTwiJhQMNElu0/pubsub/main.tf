resource "google_pubsub_topic" "tracker_topic" {
  name    = "resource-tracker-topic"
  project = var.project_id
}

resource "google_pubsub_subscription" "tracker_subscription" {
  name    = "resource-tracker-sub"
  topic   = google_pubsub_topic.tracker_topic.name
  project = var.project_id
}

