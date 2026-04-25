resource "aws_efs_file_system" "efs" {
  creation_token = var.name
  encrypted      = true

  tags = {
    Name = var.name
  }
}

resource "aws_efs_mount_target" "mount" {
  depends_on = [aws_efs_file_system.efs]
  count      = length(var.private_subnets_ids)

  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.private_subnets_ids[count.index]
  security_groups = [var.efs_sg]
}

