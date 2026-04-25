resource "aws_instance" "web_master" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.sg_web_public]
  associate_public_ip_address = true
  user_data_replace_on_change = true
  user_data = templatefile(
    "${path.module}/user_data.sh",
    {
      efs_dns = var.efs_dns
    }
  )

  tags = {
    Name = "wordpress-master"
  }
}