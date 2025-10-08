output "cluster_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.name
}

output "kube_config" {
  description = "Raw kubeconfig for AKS"
  value       = azurerm_kubernetes_cluster.main.kube_config_raw
}
