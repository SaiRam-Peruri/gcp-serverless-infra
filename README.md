# GCP Serverless Infra with Terragrunt

## Overview
This project provisions a complete Google Cloud Platform (GCP) serverless infrastructure using reusable Terraform modules managed by Terragrunt. It supports multiple environments (`dev`, `stage`, `prod`) and automates resource tracking, logging, and event-driven workflows.

## Features
- **Cloud Function**: Python function triggered by Pub/Sub, logs GCP resource state to GCS.
- **Pub/Sub**: Topic and subscription for event-driven automation.
- **Cloud Scheduler**: Schedules daily jobs to trigger Cloud Function.
- **Cloud Run**: Deploys a sample public Cloud Run service.
- **Storage**: GCS bucket for logs.
- **IAM**: Least-privilege roles for secure operation.
- **Modular & Scalable**: All resources are defined as reusable modules.
- **Multi-Environment**: Terragrunt enables safe, DRY management of dev, stage, and prod.

## Why Use This Setup?
- **Automated Resource Tracking**: Daily logs of GCP resources for audit, compliance, and cost control.
- **Event-Driven Automation**: Serverless workflows with no manual intervention.
- **Security**: IAM roles follow least privilege.
- **Separation of Environments**: Safe, isolated deployments for each environment.
- **Easy Extensibility**: Add new modules or services as needed.

## Usage
1. **Clone the repo and set up your GCP credentials.**
2. **Build your function code and zip it as `function-source.zip`, placing it in `modules/cloud_function/`.**
3. **Configure your environment in `envs/dev/terragrunt.hcl` (or `stage`/`prod`).**
4. **Run Terragrunt commands:**
   ```sh
   cd envs/dev
   terragrunt init
   terragrunt plan
   terragrunt apply
   ```
5. **Check outputs and logs in your GCS bucket.**

## Project Structure
```
gcp-serverless-infra/
├── .gitignore
├── bfg-1.15.0.jar
├── envs/
│   ├── dev/
│   │   ├── .terraform.lock.hcl
│   │   ├── .terragrunt-cache/
│   │   └── terragrunt.hcl
│   ├── prod/
│   │   └── terragrunt.hcl
│   └── stage/
│       └── terragrunt.hcl
├── function-code/
│   ├── main.py
│   └── requirements.txt
├── gcp-second-project-464220-072c47777e8c.json
├── main.tf
├── modules/
│   ├── cloud_function/
│   │   ├── function-source.zip
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   ├── cloud_run/
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   ├── iam/
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   ├── pubsub/
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   ├── scheduler/
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   ├── storage/
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   ├── main.tf
│   ├── output.tf
│   └── variables.tf
├── output.tf
├── provider.tf
├── README.md
├── terraform.tfvars
├── terragrunt.hcl
└── variable.tf
```

## Extending
- Add more functions, triggers, or services by creating new modules or extending existing ones.
- Use different GCP projects or regions per environment by editing the relevant `terragrunt.hcl`.
- Add new environments by copying and customizing the `envs/dev` folder.

## Requirements
- [Terraform](https://www.terraform.io/)
- [Terragrunt](https://terragrunt.gruntwork.io/)
- [gcloud CLI](https://cloud.google.com/sdk/docs/install)
- GCP service account with appropriate permissions

## Repository Hygiene & Large Files
- `.gitignore` excludes `.terraform`, `.terragrunt-cache`, and build artifacts.
- If you encounter git errors about large files, use [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/) to remove them from history and force-push.
- After history rewrite, collaborators must re-clone or reset their local copies.

---
**This setup provides a production-grade, auditable, and modular GCP serverless foundation for any team or project.**
