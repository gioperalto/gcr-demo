# Deploy web app service via Cloud Run
resource "google_cloud_run_service" "web_app_service" {
  name     = "web-app-service"
  location = var.region
  template {
    spec {
      containers {
        image = "${var.image_url}"
        ports {
          container_port = var.port
        }
        startup_probe {
          http_get {
            path = "/"
            port = var.port
          }
        }
      }
    }
  }
}

resource "google_cloud_run_service_iam_policy" "web_app_service" {
  service     = google_cloud_run_service.web_app_service.name
  location    = google_cloud_run_service.web_app_service.location
  policy_data = data.google_iam_policy.public_iam_policy.policy_data
}

data "google_iam_policy" "public_iam_policy" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}