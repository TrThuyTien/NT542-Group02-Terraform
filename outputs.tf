output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_app_subnets" {
  value = module.vpc.private_app_subnets
}

output "private_data_subnets" {
  value = module.vpc.private_data_subnets
}

output "web_sg" {
  value = module.security_groups.web_sg
}

output "db_sg" {
  value = module.security_groups.db_sg
}

output "redis_sg" {
  value = module.security_groups.redis_sg
}

output "bastion_ip" {
  value = module.bastion.bastion_ip
}

output "wordpress_web_master_public_ip" {
  value = module.wordpress_web_master.public_ip
}

output "efs_dns" {
  value = module.efs.efs_dns
}