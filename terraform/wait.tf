# Wait for Dataflow 'producer' SA to be created.
resource "time_sleep" "dataflow_sa_creation" {
  depends_on      = [google_service_account.dataflow_datadog_export_sa]
  create_duration = "60s"
}