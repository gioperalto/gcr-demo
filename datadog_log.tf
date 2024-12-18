resource "google_pubsub_topic" "export-logs-to-datadog" {
  name = "export-logs-to-datadog"
}

resource "google_pubsub_subscription" "datadog-logs" {
  name  = "datadog-logs"
  topic = google_pubsub_topic.export-logs-to-datadog.name

  message_retention_duration = "604800s"
  retain_acked_messages      = false
  ack_deadline_seconds       = 60

  push_config {
    push_endpoint = "https://gcp-intake.logs.datadoghq.com/v1/input/${var.datadog_key}/"
  }
}

resource "google_logging_project_sink" "datadog-sink" {
  name                   = "datadog-sink"
  destination            = "pubsub.googleapis.com/${google_pubsub_topic.export-logs-to-datadog.id}"
  filter                 = ""
  unique_writer_identity = true
}

resource "google_project_iam_member" "pubsub-publisher-permisson" {
  role    = "roles/pubsub.publisher"
  member  = google_logging_project_sink.datadog-sink.writer_identity
  project = var.project
}