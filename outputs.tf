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
