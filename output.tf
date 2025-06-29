output "cloud_run_url" {
  value = module.cloud_run.url
}

output "function_name" {
  value = module.cloud_function.name
}

output "cloud_function_name" {
  value = module.cloud_function.name
}

output "pubsub_topic_name" {
  value = module.pubsub.topic_name
}

output "storage_bucket_name" {
  value = module.storage.bucket_name
}
