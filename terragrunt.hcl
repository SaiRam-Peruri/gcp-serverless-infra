# Root Terragrunt configuration
# This keeps common configuration DRY

remote_state {
  backend = "gcs"
  config = {
    bucket         = "resource-tracker-logs"
    prefix         = "terragrunt/state/${path_relative_to_include()}/terraform.tfstate"
    project        = "gcp-second-project-464220"
    location       = "us-central1"
  }
}

locals {
  project_id = "gcp-second-project-464220"
  region     = "us-central1"
}
