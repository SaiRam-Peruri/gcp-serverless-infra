# NOTE: This file is not used by Terragrunt. See /modules for active configuration.
# All active Terraform code is now in the /modules directory.

terraform {
  backend "gcs" {}
}

module "storage" {
  source     = "./modules/storage"
  project_id = var.project_id
}

module "pubsub" {
  source     = "./modules/pubsub"
}

module "cloud_function" {
  source      = "./modules/cloud_function"
  project_id  = var.project_id
  region      = var.region
  topic_name  = module.pubsub.topic_name
  bucket_name = module.storage.bucket_name
}

module "scheduler" {
  source     = "./modules/scheduler"
  project_id = var.project_id
  region     = var.region
  topic_name = module.pubsub.topic_name
}

module "cloud_run" {
  source     = "./modules/cloud_run"
  project_id = var.project_id
  region     = var.region
}

# Get service account emails for IAM
# (Assumes default service accounts, or you can output from modules)
data "google_cloudfunctions2_function" "function" {
  name     = module.cloud_function.name
  project  = var.project_id
  location = var.region
}

data "google_project" "project" {
  project_id = var.project_id
}

module "iam" {
  source             = "./modules/iam"
  project_id         = var.project_id
  function_sa_email  = data.google_cloudfunctions2_function.function.service_config[0].service_account_email
  scheduler_sa_email = "service-${data.google_project.project.number}@gcp-sa-cloudscheduler.iam.gserviceaccount.com"
  topic_name         = module.pubsub.topic_name
}

output "cloud_run_service_name" {
  value = module.cloud_run.service_name
}

output "cloud_run_service_url" {
  value = module.cloud_run.service_url
}
