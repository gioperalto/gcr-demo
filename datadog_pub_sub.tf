#######################################################
######### PUB/SUB TOPIC AND SUBSCRIPTION  #############
#######################################################

resource "google_pubsub_topic" "datadog_topic" {
  name   = "export-logs-to-datadog"
  labels = { pubsub-label = "datadog_terraform" }
}

resource "google_pubsub_subscription" "datadog_topic_sub" {
  name  = "datadog-logs"
  topic = google_pubsub_topic.datadog_topic.name

  message_retention_duration = "604800s"
  retain_acked_messages      = false
  ack_deadline_seconds       = 10

  expiration_policy {
    ttl = "2678400s"
  }
}

#########################################################
################## DEAD LETTER TOPIC  ###################
#########################################################

#This additional Topic/Subscription are created to handle any log messages rejected by the Datadog API.

resource "google_pubsub_topic" "output_dead_letter" {
  name    = "output-deadletter-topic"
  project = var.project
}

resource "google_pubsub_subscription" "output_dead_letter_sub" {
  ack_deadline_seconds = 10

  expiration_policy {
    ttl = "2678400s"
  }

  message_retention_duration = "604800s"
  name                       = "output-deadletter-topic-sub"
  project                    = var.project
  topic                      = google_pubsub_topic.output_dead_letter.id
}