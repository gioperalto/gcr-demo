# Create a Google Service Account for Datadog GCP Integration.
resource "google_service_account" "datadog_gcp_integration_sa" {
  account_id   = "datadog-sa"
  display_name = "Datadog Service Account"
  description  = "Service account used for Datadog GCP Integration."
}

# Define IAM roles needed for the Dataflow Service Account
resource "google_project_iam_member" "dataflow_datadog_sa_roles" {
  project = var.project
  for_each = toset([
    "roles/monitoring.viewer",
    "roles/compute.viewer",
    "roles/cloudasset.viewer",
    "roles/browser"
  ])
  role   = each.key
  member = "serviceAccount:${google_service_account.datadog_gcp_integration_sa.email}"
}