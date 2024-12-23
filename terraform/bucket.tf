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