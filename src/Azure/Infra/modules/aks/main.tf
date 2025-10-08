resource "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true 
  default_node_pool {
    name            = var.default_node_pool_name
    node_count      = var.default_node_count
    vm_size         = var.default_vm_size
    vnet_subnet_id  = var.subnet_id
    os_disk_size_gb = var.default_os_disk_size_gb
  }

  network_profile {
    network_plugin     = "azure"
    service_cidr       = var.aks_service_cidr
    dns_service_ip     = var.aks_dns_service_ip
  }

  tags = var.tags
}

# --- Mandatory Permissions for Azure CNI (VNet Integration) ---

resource "azurerm_role_assignment" "aks_subnet_contributor" {
  scope                = var.subnet_id
  role_definition_name = "Network Contributor" 
  principal_id         = azurerm_kubernetes_cluster.main.identity[0].principal_id
}

# --- Mandatory Permissions for Azure Container Registry (ACR) Image Pull ---

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull" 
  principal_id         = azurerm_kubernetes_cluster.main.identity[0].principal_id
}