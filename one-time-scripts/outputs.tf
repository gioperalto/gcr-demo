output "datadog_sa_email" {
  description = "The email of the created Datadog service account."
  value       = google_service_account.datadog_gcp_integration_sa.email
}