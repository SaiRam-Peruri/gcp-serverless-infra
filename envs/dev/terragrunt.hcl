include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//"
}

inputs = {
  project_id = "gcp-second-project-464220"
  region     = "us-central1"
}
