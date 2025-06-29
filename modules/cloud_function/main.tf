# Cloud Function Module
# Deploys a Python Cloud Function triggered by a Pub/Sub topic and writes logs to GCS

resource "google_storage_bucket_object" "function_source" {
  name   = "function-source.zip"
  bucket = var.bucket_name
  source = "${path.module}/function-source.zip"
}

resource "google_cloudfunctions2_function" "function" {
  name        = "resource-logger"
  project     = var.project_id
  location    = var.region
  build_config {
    runtime     = "python311"
    entry_point = "log_resource"
    source {
      storage_source {
        bucket = var.bucket_name
        object = google_storage_bucket_object.function_source.name
      }
    }
  }
  service_config {
    environment_variables = {
      BUCKET_NAME = var.bucket_name
    }
  }
  event_trigger {
    event_type = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic = "projects/${var.project_id}/topics/${var.topic_name}"
    trigger_region = var.region
  }
}
