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

module "subnets_module" {
  source = "./modules/subnets_module"

  vpc_id          = module.vpc_module.vpc_id
  env             = var.env
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}


module "public_route_table_module" {
  source = "./modules/route_table_module"

  vpc_cidr_block    = var.vpc_cidr_block
  vpc_id            = module.vpc_module.vpc_id
  gateway_id        = module.igw_module.igw_id
  env               = var.env
  public_subnets_id = module.subnets_module.public_subnets_id
}


  