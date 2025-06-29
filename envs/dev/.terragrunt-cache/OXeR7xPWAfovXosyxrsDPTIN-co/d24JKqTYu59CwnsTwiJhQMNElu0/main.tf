terraform {
  backend "gcs" {}
}

module "storage" {
  source     = "./storage"
  project_id = var.project_id
}

module "pubsub" {
  source     = "./pubsub"
  project_id = var.project_id
}

module "cloud_function" {
  source      = "./cloud_function"
  project_id  = var.project_id
  region      = var.region
  topic_name  = module.pubsub.topic_name
  bucket_name = module.storage.bucket_name
}

module "scheduler" {
  source     = "./scheduler"
  project_id = var.project_id
  region     = var.region
  topic_name = module.pubsub.topic_name
}

module "cloud_run" {
  source     = "./cloud_run"
  project_id = var.project_id
  region     = var.region
}

# Get service account emails for IAM
# (Assumes default service accounts, or you can output from modules)
data "google_cloudfunctions2_function" "function" {
  name     = module.cloud_function.name
  project  = var.project_id
  location = var.region
  depends_on = [module.cloud_function]
}

data "google_project" "project" {
  project_id = var.project_id
}

module "iam" {
  source             = "./iam"
  project_id         = var.project_id
  function_sa_email  = data.google_cloudfunctions2_function.function.service_config[0].service_account_email
  scheduler_sa_email = "service-${data.google_project.project.number}@gcp-sa-cloudscheduler.iam.gserviceaccount.com"
  topic_name         = module.pubsub.topic_name
}
