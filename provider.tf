# NOTE: This file is not used by Terragrunt. See /modules for active configuration.
# All active Terraform code is now in the /modules directory.

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
}