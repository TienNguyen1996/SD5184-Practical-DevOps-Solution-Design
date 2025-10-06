output "node_role_arn" {
  description = "ARN of the IAM role for EKS node group"
  value       = aws_iam_role.node_role.arn
}

output "cluster_role_arn" {
  description = "ARN of the IAM role for EKS cluster"
  value       = aws_iam_role.cluster_role.arn
}
