provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "ci_cd" {
  metadata {
    name = "ci-cd-namespace"
  }
}

resource "kubernetes_deployment" "ci_cd_app" {
  metadata {
    name      = "ci-cd-app"
    namespace = kubernetes_namespace.ci_cd.metadata[0].name
    labels = {
      app = "ci-cd-app"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "ci-cd-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "ci-cd-app"
        }
      }

      spec {
        container {
          name  = "ci-cd-app-container"
          image = "<your-docker-image>:latest"

          port {
            container_port = 5000
          }

          env {
            name  = "FLASK_ENV"
            value = "production"
          }

          readiness_probe {
            http_get {
              path = "/health"
              port = 5000
            }

            initial_delay_seconds = 5
            period_seconds        = 10
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = 5000
            }

            initial_delay_seconds = 15
            period_seconds        = 20
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "ci_cd_app_service" {
  metadata {
    name      = "ci-cd-app-service"
    namespace = kubernetes_namespace.ci_cd.metadata[0].name
    labels = {
      app = "ci-cd-app"
    }
  }

  spec {
    selector = {
      app = "ci-cd-app"
    }

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 5000
    }

    type = "LoadBalancer"
  }
}
