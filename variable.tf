# NOTE: This file is not used by Terragrunt. See /modules for active configuration.
# All active Terraform code is now in the /modules directory.

variable "project_id" {
  description = "The ID of the project in which the resources will be created."
  type        = string
  default     = "gcp-second-project-464220"

}

variable "region" {
  description = "The region in which the resources will be created."
  type        = string
  default     = "us-central1"   
  
}

variable "credentials_file" {
  description = "The path to the service account key file."
  type        = string
  default     = "gcp-second-project-464220-072c47777e8c.json"
  
}