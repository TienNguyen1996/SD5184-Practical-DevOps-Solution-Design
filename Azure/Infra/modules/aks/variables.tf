variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
  default     = "pi-sharp-aks-cluster"
  validation {
    condition     = length(var.cluster_name) > 3
    error_message = "Cluster name must be longer than 3 characters."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the AKS node pool"
}

variable "identity_id" {
  type        = string
  description = "User-assigned managed identity ID"
}

variable "acr_id" {
  type        = string
  description = "Azure Container Registry ID"
}

variable "acr_depends_on" {
  type        = any
  description = "Dummy input to enforce dependency on ACR"
  default     = null
}

