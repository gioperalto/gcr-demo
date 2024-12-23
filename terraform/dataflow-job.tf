resource "google_dataflow_job" "pubsub_stream_to_datadog" {
  name                    = "pubsub-stream-to-datadog"
  template_gcs_path       = "gs://dataflow-templates-${var.region}/latest/Cloud_PubSub_to_Datadog"
  temp_gcs_location       = "gs://${google_storage_bucket.temp_files_bucket.id}/tmp_dir"
  region                  = var.region
  service_account_email   = google_service_account.dataflow_datadog_export_sa.email
  enable_streaming_engine = true
  parameters = {
    inputSubscription     = google_pubsub_subscription.datadog_topic_sub.id,
    url                   = var.datadog_logs_api_url,
    apiKeySecretId        = google_secret_manager_secret_version.secret_version.name,
    apiKeySource          = "SECRET_MANAGER",
    outputDeadletterTopic = google_pubsub_topic.output_dead_letter.id
  }
  on_delete  = "cancel"
  labels     = { dataflow-job-label = "datadog_terraform" }
  depends_on = [google_project_service.enable_apis, time_sleep.dataflow_sa_creation]
}