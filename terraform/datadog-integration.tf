resource "datadog_integration_gcp_sts" "datadog_integration" {
  client_email    = google_service_account.datadog_gcp_integration_sa.email
  host_filters    = []
  automute        = true
  is_cspm_enabled = false
}