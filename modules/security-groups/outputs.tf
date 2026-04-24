output "bastion_sg" {
  value = aws_security_group.bastion.id
}

output "web_sg" {
  value = aws_security_group.web.id
}

output "db_sg" {
  value = aws_security_group.db.id
}

output "redis_sg" {
  value = aws_security_group.redis.id
}
