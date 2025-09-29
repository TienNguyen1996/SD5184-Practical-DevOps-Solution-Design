variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  validation {
    condition     = can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+/\\d+$", var.cidr_block))
    error_message = "Must be a valid CIDR block."
  }
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  validation {
    condition     = length(var.azs) >= 2
    error_message = "At least two AZs are required for high availability."
  }
}
