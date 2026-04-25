resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.bastion_sg]
  associate_public_ip_address = true
  tags = {
    Name = "bastion-host"
  }
}