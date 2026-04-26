output "redis_endpoint" {
  description = "Địa chỉ kết nối đến Redis Cache"
  value       = aws_elasticache_replication_group.redis_cluster.primary_endpoint_address
}

output "redis_port" {
  value = aws_elasticache_replication_group.redis_cluster.port
}
