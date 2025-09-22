output "jenkins_public_ip" {
  description = "Public IP of the Jenkins EC2 instance"
  value       = aws_instance.jenkins.public_ip
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.repo.repository_url
}

output "private_key" {
  description = "Private key for SSH access"
  value       = tls_private_key.jenkins_key.private_key_pem
  sensitive   = true
}
