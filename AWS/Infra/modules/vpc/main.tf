resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = { Name = "pi-sharp-vpc" }
}

resource "aws_subnet" "public" {
  count = length(var.azs)
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-${count.index}" }
}

resource "aws_subnet" "private" {
  count = length(var.azs)
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr_block, 8, count.index + length(var.azs))
  availability_zone = var.azs[count.index]
  tags = { Name = "private-subnet-${count.index}" }
}
