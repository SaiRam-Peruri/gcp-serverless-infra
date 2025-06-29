import base64
import os
import subprocess
from datetime import datetime
from google.cloud import storage

def run_gcloud_command(command):
    result = subprocess.run(command, shell=True, text=True, capture_output=True)
    return result.stdout if result.returncode == 0 else result.stderr

def write_to_gcs(bucket_name, filename, content):
    client = storage.Client()
    bucket = client.bucket(bucket_name)
    blob = bucket.blob(filename)
    blob.upload_from_string(content)
    print(f"Uploaded log to gs://{bucket_name}/{filename}")

def log_resource(event, context):
    timestamp = datetime.utcnow().strftime("%Y-%m-%d_%H-%M-%S")
    bucket_name = os.environ["BUCKET_NAME"]
    log_file = f"logs/gcp_resource_log_{timestamp}.txt"

    sections = []

    # Example resources
    sections.append("=== GCS Buckets ===")
    sections.append(run_gcloud_command("gsutil ls"))

    sections.append("=== Pub/Sub Topics ===")
    sections.append(run_gcloud_command("gcloud pubsub topics list --format='table(name)'"))

    sections.append("=== Cloud Functions ===")
    sections.append(run_gcloud_command("gcloud functions list --format='table(name, status, entryPoint)'"))

    sections.append("=== Cloud Run Services ===")
    sections.append(run_gcloud_command("gcloud run services list --platform managed --format='table(name, url)'"))

    sections.append("=== IAM Roles ===")
    sections.append(run_gcloud_command("gcloud projects get-iam-policy $GOOGLE_CLOUD_PROJECT --flatten='bindings[].members' --format='table(bindings.role, bindings.members)'"))

    content = "\n\n".join(sections)
    write_to_gcs(bucket_name, log_file, content)
