output "rds_endpoint" {
  description = "Địa chỉ kết nối đến Database Cluster"
  value       = aws_rds_cluster.aurora_cluster.endpoint
}

output "rds_database_name" {
  description = "Tên Database"
  value       = aws_rds_cluster.aurora_cluster.database_name
}

output "rds_username" {
  value = aws_rds_cluster.aurora_cluster.master_username
}

output "rds_port" {
  value = aws_rds_cluster.aurora_cluster.port
}
