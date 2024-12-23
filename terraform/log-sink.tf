resource "google_logging_project_sink" "datadog_sink" {
  name                   = "datadog-sink"
  destination            = "pubsub.googleapis.com/${google_pubsub_topic.datadog_topic.id}"
  unique_writer_identity = true
}

resource "google_project_iam_member" "pubsub_publisher_permisson" {
  role    = "roles/pubsub.publisher"
  member  = google_logging_project_sink.datadog_sink.writer_identity
  project = var.project
}