variable "node_role_name" {
  description = "Name of the IAM role for EKS node group (used by EC2 worker nodes)"
  type        = string
  default     = "pi-sharp-node-role"
  validation {
    condition     = length(var.node_role_name) > 3
    error_message = "Node role name must be at least 4 characters."
  }
}

variable "cluster_role_name" {
  description = "Name of the IAM role for EKS cluster (used by control plane)"
  type        = string
  default     = "pi-sharp-cluster-role"
  validation {
    condition     = length(var.cluster_role_name) > 3
    error_message = "Cluster role name must be at least 4 characters."
  }
}

variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  validation {
    condition = contains([
      "us-east-1", "us-east-2", "us-west-1", "us-west-2",
      "af-south-1", "ap-east-1", "ap-south-1", "ap-northeast-1",
      "ap-northeast-2", "ap-northeast-3", "ap-southeast-1",
      "ap-southeast-2", "ca-central-1", "eu-central-1",
      "eu-west-1", "eu-west-2", "eu-west-3", "eu-north-1",
      "eu-south-1", "me-south-1", "sa-east-1"
    ], var.aws_region)

    error_message = "Invalid AWS region. Please use a valid region code like 'us-east-1'."
  }
}

variable "ecr_repo_name" {
  description = "Name of the ECR repository to allow image pulls from"
  type        = string
  validation {
    condition     = length(var.ecr_repo_name) > 1
    error_message = "Repository name must be at least 2 characters."
  }
}
