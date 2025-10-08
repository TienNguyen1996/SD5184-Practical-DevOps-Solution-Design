variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
  default     = "pi-sharp-vnet"
  validation {
    condition     = length(var.vnet_name) > 3
    error_message = "VNet name must be longer than 3 characters."
  }
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the VNet"
  default     = ["10.0.0.0/16"]
}

variable "subnet_names" {
  type        = list(string)
  description = "Names of the subnets"
  default     = ["aks-subnet"]
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "CIDR blocks for the subnets"
  default     = ["10.0.1.0/24"]
}

# === START OF ADDITION: Variable for Subnet Delegation ===

variable "subnet_delegations" {
  description = "A list of delegation objects corresponding to subnets. Use null for a subnet that does not require delegation."
  type = list(object({
    # The Azure service name for delegation, e.g., 'Microsoft.ContainerService/managedClusters'
    service_name = string 
    # Optional list of actions for the service delegation (often not needed for standard AKS)
    actions      = optional(list(string), []) 
  }))
  # Default is an empty list, assuming most subnets will not be delegated
  default = []
}

# === END OF ADDITION ===