variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  type        = string
}

variable "azs" {
  description = "Availability zones for EKS"
  type        = list(string)
  validation {
    condition     = length(var.azs) >= 2
    error_message = "EKS must span at least two AZs for high availability."
  }
}

variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for the EKS node group"
  type        = string
}
