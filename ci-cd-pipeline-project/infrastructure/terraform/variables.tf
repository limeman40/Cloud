variable "namespace" {
  description = "The namespace for the CI/CD project."
  type        = string
  default     = "ci-cd-namespace"
}

variable "app_name" {
  description = "The name of the application."
  type        = string
  default     = "ci-cd-app"
}

variable "replicas" {
  description = "The number of application replicas."
  type        = number
  default     = 3
}

variable "container_image" {
  description = "The Docker image for the application."
  type        = string
  default     = "<your-docker-image>:latest"
}

variable "container_port" {
  description = "The container port for the application."
  type        = number
  default     = 5000
}

variable "service_port" {
  description = "The port for the Kubernetes service."
  type        = number
  default     = 80
}

variable "env_variables" {
  description = "Environment variables for the application."
  type        = map(string)
  default     = {
    FLASK_ENV = "production"
  }
}
