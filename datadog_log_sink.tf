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

#########################################################################
# CREATE A BUCKET WITH A RANDOM ID NAME TO PUT DATAFLOW TEMPORARY FILES #
#########################################################################

resource "random_id" "random" {
  byte_length = 4
}

resource "google_storage_bucket" "temp_files_bucket" {
  name     = lower("tmp-${random_id.random.hex}")
  location = var.region

  uniform_bucket_level_access = true
  storage_class               = "STANDARD"
  public_access_prevention    = "enforced"
  labels                      = { storage-bucket-label = "datadog_terraform" }
}