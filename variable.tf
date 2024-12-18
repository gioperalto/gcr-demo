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