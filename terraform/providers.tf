terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
    datadog = {
      source  = "datadog/datadog"
      version = "3.50.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}