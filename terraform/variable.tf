# variable.tf 

variable "datadog_key" {
  type        = string
  description = "Datadog API Key"
}

variable "project" {
  type        = string
  description = "GCP project"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "datadog_logs_api_url" {
  type        = string
  description = "Datadog Logs API URL, it will depends on the Datadog site region (https://docs.datadoghq.com/integrations/google_cloud_platform/#4-create-and-run-the-dataflow-job)."
}