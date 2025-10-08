output "aks_cluster_name" { value = module.aks.cluster_name }
output "acr_login_server" { value = module.acr.login_server }
output "aks_kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}
