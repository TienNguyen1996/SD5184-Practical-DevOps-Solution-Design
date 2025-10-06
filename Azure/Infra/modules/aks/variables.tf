variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
  default     = "pi-sharp-aks-cluster"
  validation {
    # AKS cluster name must be between 1 and 63 characters and contain only letters, numbers, or hyphens.
    condition     = length(var.cluster_name) >= 1 && length(var.cluster_name) <= 63 && can(regex("^[a-zA-Z0-9-]*$", var.cluster_name))
    error_message = "Cluster name must be between 1 and 63 characters, and contain only letters, numbers, or hyphens."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "East US"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the AKS node pool"
  validation {
    # Simple check for Azure Resource ID format to catch common errors
    condition     = can(regex("^/subscriptions/.*/resourceGroups/.*/providers/Microsoft\\.Network/virtualNetworks/.*/subnets/.*$", var.subnet_id))
    error_message = "Subnet ID must be a valid Azure resource ID format."
  }
}

variable "acr_id" {
  type        = string
  description = "Azure Container Registry ID (Required for ACR Pull Role Assignment)"
  validation {
    # Simple check for ACR Resource ID format
    condition     = can(regex("^/subscriptions/.*/resourceGroups/.*/providers/Microsoft\\.ContainerRegistry/registries/.*$", var.acr_id))
    error_message = "ACR ID must be a valid Azure resource ID format for a registry."
  }
}

# --- New Variables for Full Parameterization (Based on last main.tf) ---

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS cluster."
  default     = "pi-sharp-aks"
}

variable "default_node_pool_name" {
  type        = string
  description = "The name of the default node pool."
  default     = "systempool"
  validation {
    condition     = length(var.default_node_pool_name) <= 12
    error_message = "Default node pool name must be 12 characters or less."
  }
}

variable "default_node_count" {
  type        = number
  description = "The initial number of agent nodes to create in the default node pool."
  default     = 3
  validation {
    condition     = var.default_node_count >= 1
    error_message = "Default node count must be 1 or greater."
  }
}

variable "default_vm_size" {
  type        = string
  description = "The size of the Virtual Machine for the agent nodes."
  default     = "Standard_DS2_v2"
}

variable "default_os_disk_size_gb" {
  type        = number
  description = "The size of the OS disk in gigabytes to be used by the nodes."
  default     = 128
}

variable "aks_service_cidr" {
  type        = string
  description = "CIDR block for Kubernetes internal services."
  default     = "10.2.0.0/16"
}

variable "aks_dns_service_ip" {
  type        = string
  description = "IP address for the Kubernetes DNS service (must be within aks_service_cidr)."
  default     = "10.2.0.10"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the AKS cluster resource."
  default = {
    Environment = "Development"
    Project     = "PI-Sharp"
  }
}
