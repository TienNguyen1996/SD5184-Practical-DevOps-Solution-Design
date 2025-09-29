resource "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "pi-sharp"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_DS2_v2"
    vnet_subnet_id  = var.subnet_id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.identity_id]
  }

  network_profile {
    network_plugin = "azure"
  }

  tags = {
    Environment = "pi-sharp"
  }

  depends_on = [var.acr_depends_on]

}
