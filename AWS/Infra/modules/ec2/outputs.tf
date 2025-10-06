output "instance_id" {
  value       = var.enable_jenkins ? aws_instance.jenkins[0].id : null
  description = "ID of the Jenkins EC2 instance"
}

output "public_ip" {
  value       = var.enable_jenkins ? aws_instance.jenkins[0].public_ip : null
  description = "Public IP of the Jenkins EC2 instance"
}
