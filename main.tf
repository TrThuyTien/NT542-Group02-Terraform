module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnets       = var.public_subnets
  private_app_subnets  = var.private_app_subnets
  private_data_subnets = var.private_data_subnets
  azs                  = var.azs
}

module "security_groups" {
  depends_on = [module.vpc]
  source     = "./modules/security-groups"

  vpc_id   = module.vpc.vpc_id
  vpc_cidr = var.vpc_cidr
  # alb_sg  = module.alb.alb_sg
}

module "efs" {
  depends_on          = [module.security_groups]
  source              = "./modules/efs"
  vpc_id              = module.vpc.vpc_id
  private_subnets_ids = module.vpc.public_subnets
  efs_sg              = module.security_groups.efs_sg
}

module "bastion" {
  source           = "./modules/bastion"
  vpc_id           = module.vpc.vpc_id
  bastion_sg       = module.security_groups.bastion_sg
  public_subnet_id = module.vpc.public_subnets[0]
  key_name         = var.key_name
  ami_id           = var.ami_id
}

module "wordpress_web_master" {
  depends_on       = [module.efs]
  source           = "./modules/ec2-web"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnets[0]
  sg_web_public    = module.security_groups.sg_web_public
  ami_id           = var.ami_id
  key_name         = var.key_name
  efs_dns          = module.efs.efs_dns
}