output "cloud_run_service_name" {
  value = module.cloud_run.service_name
}

output "cloud_run_service_url" {
  value = module.cloud_run.service_url
}

output "bucket_name" {
  value = module.storage.bucket_name
}

output "pubsub_topic_name" {
  value = module.pubsub.topic_name
}

output "cloud_function_name" {
  value = module.cloud_function.name
}
