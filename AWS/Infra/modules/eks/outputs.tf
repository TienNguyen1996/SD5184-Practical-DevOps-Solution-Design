output "cluster_id" {
  description = "ID of the EKS cluster"
  value       = aws_eks_cluster.main.id
}

output "cluster_endpoint" {
  description = "Endpoint of the EKS cluster"
  value       = aws_eks_cluster.main.endpoint
}

output "node_group_name" {
  description = "Name of the EKS node group"
  value       = aws_eks_node_group.workers.node_group_name
}
