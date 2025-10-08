module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.vpc_cidr
  azs        = var.availability_zones
}

module "ec2" {
  source        = "./modules/ec2"
  subnet_ids    = module.vpc.public_subnets
  vpc_id        = module.vpc.vpc_id
  instance_type = var.instance_type
}

module "ecr" {
  source    = "./modules/ecr"
  repo_name = var.ecr_repo_name
}

module "iam" {
  source            = "./modules/iam"
  node_role_name    = var.node_role_name
  cluster_role_name = var.cluster_role_name
  aws_region        = var.aws_region
  ecr_repo_name     = var.ecr_repo_name
}

module "eks" {
  source           = "./modules/eks"
  cluster_name     = var.cluster_name
  subnet_ids       = module.vpc.private_subnets
  vpc_id           = module.vpc.vpc_id
  azs              = var.availability_zones
  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn
}
