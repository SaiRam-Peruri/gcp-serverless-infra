# IAM Module
# Grants roles to Cloud Function and Scheduler

resource "google_project_iam_member" "function_pubsub_subscriber" {
  project = var.project_id
  role    = "roles/pubsub.subscriber"
  member  = "serviceAccount:${var.function_sa_email}"
}

resource "google_project_iam_member" "function_storage_admin" {
  project = var.project_id
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${var.function_sa_email}"
}

resource "google_pubsub_topic_iam_member" "scheduler_pubsub_publisher" {
  project = var.project_id
  topic   = var.topic_name
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${var.scheduler_sa_email}"
}
