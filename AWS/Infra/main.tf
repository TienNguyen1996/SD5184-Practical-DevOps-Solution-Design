data "aws_vpc" "default" {
  default = true
}

resource "tls_private_key" "jenkins_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "sd5184_key" {
  key_name   = "${var.environment}-key"
  public_key = tls_private_key.jenkins_key.public_key_openssh
}

resource "aws_security_group" "jenkins_sg" {
  name        = "${var.environment}-jenkins-sg"
  description = "Allow SSH and Jenkins access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.sd5184_key.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

user_data = <<-EOF
  #!/bin/bash
  exec > /var/log/user-data.log 2>&1
  set -x

  yum update -y
  amazon-linux-extras install epel -y
  yum install -y java-17-amazon-corretto docker git
  
  systemctl enable docker
  systemctl start docker
  usermod -aG docker ec2-user

  wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
  rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

  yum install -y jenkins
  systemctl enable jenkins
  systemctl start jenkins
EOF

  tags = {
    Name        = "${var.environment}-jenkins"
    Environment = var.environment
  }
}

resource "aws_ecr_repository" "repo" {
  name                 = "${var.environment}-app-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}
