variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Azure region for all resources"
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "vnet_name" {
  type        = string
  default     = "pi-sharp-vnet"
  description = "Name of the virtual network"
  validation {
    condition     = length(var.vnet_name) > 3
    error_message = "VNet name must be longer than 3 characters."
  }
}

variable "vnet_address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "Address space for the virtual network"
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

variable "identity_name" {
  type        = string
  default     = "pi-sharp-aks-identity"
  description = "Name of the managed identity for AKS"
  validation {
    condition     = length(var.identity_name) > 3
    error_message = "Identity name must be longer than 3 characters."
  }
}

variable "cluster_name" {
  type        = string
  default     = "pi-sharp-aks-cluster"
  description = "Name of the AKS cluster"
  validation {
    condition     = length(var.cluster_name) > 3
    error_message = "Cluster name must be longer than 3 characters."
  }
}

variable "acr_name" {
  type        = string
  default     = "pisharpacr"
  description = "Name of the Azure Container Registry"
  validation {
    condition     = length(var.acr_name) > 5
    error_message = "ACR name must be longer than 5 characters."
  }
}
