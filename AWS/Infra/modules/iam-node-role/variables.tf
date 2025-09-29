variable "role_name" {
  description = "Name of the IAM role for EKS node group"
  type        = string
  default     = "eks-node-role"
  validation {
    condition     = length(var.role_name) > 3
    error_message = "Role name must be longer than 3 characters."
  }
}
