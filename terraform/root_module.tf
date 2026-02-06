module "vpc_module" {
  source = "./modules/vpc_module"

  vpc_name       = var.vpc_name
  vpc_cidr_block = var.vpc_cidr_block
}

module "igw_module" {
  source = "./modules/igw_module"
  vpc_id = module.vpc_module.vpc_id
  env    = var.env
}

module "nat_module" {
  source = "./modules/nat_module"

  public_subnets_id = [module.subnets_module.public_subnets_id[0]]
  env               = var.env
}


module "subnets_module" {
  source = "./modules/subnets_module"

  vpc_id               = module.vpc_module.vpc_id
  env                  = var.env
  azs                  = var.azs
  public_subnets       = var.public_subnets
  presentation_subnets = var.presentation_subnets
  backend_subnets      = var.backend_subnets
}

module "security_group_module" {
  source = "./modules/security_groups"
  vpc_id = module.vpc_module.vpc_id
  nlb_subnet_cidrs = var.presentation_subnets
  env = var.env
}


module "public_route_table_module" {
  source = "./modules/route_table_module"

  vpc_cidr_block          = var.vpc_cidr_block
  vpc_id                  = module.vpc_module.vpc_id
  gateway_id              = module.igw_module.igw_id
  env                     = var.env
  public_subnets_id       = module.subnets_module.public_subnets_id
  presentation_subnets_id = module.subnets_module.presentation_subnets_id
  backend_subnets_id      = module.subnets_module.backend_subnets_id
  nat_id                  = module.nat_module.nat_id
}


module "eks_module" {
  source = "./modules/eks_module"

  eks_cluster_name    = var.eks_cluster_name
  eks_cluster_version = var.eks_cluster_version
  subnet_ids = flatten([
    module.subnets_module.presentation_subnets_id,
    module.subnets_module.backend_subnets_id
  ])
  nodes_sg_id      = module.security_group_module.nodes_sg_id
  tags             = var.tags
  env              = var.env
  desired_capacity = var.desired_capacity
  max_capacity     = var.max_capacity
  min_capacity     = var.min_capacity
  instance_types   = var.instance_types
}


module "nlb_module" {
  source = "./modules/nlb"

  nlb_name = "${var.env}-${var.nlb_name}"

  subnet_ids = flatten([
    module.subnets_module.presentation_subnets_id
  ])

  vpc_id        = module.vpc_module.vpc_id
  listener_port = var.listener_port

  target_group_name = "${var.env}-ingress-tg"
  target_group_port = 80
  target_group_arn  = module.nlb_module.target_group_arn

  tags = {
    env = var.env
    app = "shared-ingress"
  }
}


module "api_gateway_module" {
  source = "./modules/api_gateway"

  vpc_link_name = var.vpc_link_name
  listener_arn  = module.nlb_module.listener_arn
  api_name      = var.api_name
  nlb_dns       = module.nlb_module.dns_name
  vpc_link_sg_id = module.security_group_module.vpc_link_sg_id
  presentation_subnets_ids = module.subnets_module.presentation_subnets_id
  nlb_listener_arn = module.nlb_module.listener_arn
  
}


