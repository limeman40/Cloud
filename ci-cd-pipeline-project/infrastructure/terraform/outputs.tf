output "service_name" {
  description = "The name of the Kubernetes service."
  value       = kubernetes_service.ci_cd_app_service.metadata[0].name
}

output "service_ip" {
  description = "The external IP of the Kubernetes service."
  value       = kubernetes_service.ci_cd_app_service.status[0].load_balancer[0].ingress[0].ip
}

output "deployment_name" {
  description = "The name of the Kubernetes deployment."
  value       = kubernetes_deployment.ci_cd_app.metadata[0].name
}

output "namespace" {
  description = "The namespace for the CI/CD project."
  value       = kubernetes_namespace.ci_cd.metadata[0].name
}
