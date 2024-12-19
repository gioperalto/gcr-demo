# Google Cloud Run Demo

This repo deploys a Google Cloud Run NestJS service via Terraform that enables Datadog Logging. 

The project consists of:
- `cloudbuild.yaml` (for creating docker image and storing it in Artifact Registry)
- `*.tf` files (for terraform deployment + Datadog Logging)
