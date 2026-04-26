resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "lab-redis-subnet-group"
  subnet_ids = var.private_data_subnet_ids
}

resource "aws_elasticache_replication_group" "redis_cluster" {
  replication_group_id       = "lab-wordpress-redis"
  description                = "Redis cluster for WordPress cache"
  node_type                  = "cache.t3.micro"
  port                       = 6379
  parameter_group_name       = "default.redis7"
  engine_version             = "7.0"
  subnet_group_name          = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids         = [var.redis_security_group_id]
  automatic_failover_enabled = false
  num_cache_clusters         = 1
}
