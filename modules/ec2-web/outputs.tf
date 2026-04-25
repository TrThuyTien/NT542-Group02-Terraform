output "web_instance_template" {
  value = aws_instance.web_master.id
}

output "public_ip" {
  value = aws_instance.web_master.public_ip
}