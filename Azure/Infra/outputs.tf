output "aks_cluster_name" { value = module.aks.cluster_name }
output "aks_kube_config" { value = module.aks.kube_config }
output "acr_login_server" { value = module.acr.login_server }
output "vm_public_ip" { value = module.vm.public_ip }
