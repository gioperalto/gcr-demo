# Deploy NestJS service via Cloud Run
resource "google_cloud_run_service" "tf_nestjs_service" {
  name     = "tf-nestjs-service"
  location = var.region
  template {
    spec {
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project}/gcr-demo/gcr-demo_api:latest"
        ports {
          container_port = 3000
        }
        startup_probe {
          http_get {
            path = "/"
            port = 3000
          }
        }
      }
    }
  }
}

resource "google_cloud_run_service_iam_policy" "tf_nestjs_service" {
  service     = google_cloud_run_service.tf_nestjs_service.name
  location    = google_cloud_run_service.tf_nestjs_service.location
  policy_data = data.google_iam_policy.public_iam_policy.policy_data
}

data "google_iam_policy" "public_iam_policy" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}