variable "resource_group_name" {
  type        = string
  default     = "pi-sharp-rg"
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Azure region for all resources"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to all resources."
  default = {
    Environment = "Development"
    Project     = "PI-Sharp"
  }
}

variable "vnet_name" {
  type        = string
  default     = "pi-sharp-vnet"
  description = "Name of the virtual network"
  validation {
    condition     = length(var.vnet_name) >= 3
    error_message = "VNet name must be 3 characters or longer."
  }
}

variable "vnet_address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "Address space for the virtual network (must be a valid CIDR block list)"
}

variable "subnet_names" {
  type        = list(string)
  default     = ["aks-subnet"]
  description = "List of subnet names"
  validation {
    condition     = length(var.subnet_names) > 0
    error_message = "You must provide at least one subnet name."
  }
}

variable "subnet_prefixes" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "List of subnet CIDR blocks"
  validation {
    condition     = length(var.subnet_prefixes) == length(var.subnet_names)
    error_message = "Each subnet must have a corresponding CIDR block."
  }
}

variable "acr_name" {
  type        = string
  default     = "pisharpacr"
  description = "Name of the Azure Container Registry"
  validation {
    condition     = length(var.acr_name) >= 5 && length(var.acr_name) <= 50 && can(regex("^[a-z0-9]+$", var.acr_name))
    error_message = "ACR name must be 5-50 characters and contain only lowercase letters and numbers."
  }
}

variable "cluster_name" {
  type        = string
  default     = "pi-sharp-aks-cluster"
  description = "Name of the AKS cluster"
  validation {
    condition     = length(var.cluster_name) >= 1 && length(var.cluster_name) <= 63 && can(regex("^[a-zA-Z0-9-]*$", var.cluster_name))
    error_message = "Cluster name must be between 1 and 63 characters and contain only letters, numbers, or hyphens."
  }
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS cluster."
  default     = "aks-prod-dns"
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
  description = "IP address for the Kubernetes DNS service."
  default     = "10.2.0.10"
}
