resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "lab-aurora-subnet-group"
  subnet_ids = var.private_data_subnet_ids

  tags = {
    Name = "Lab Aurora DB Subnet Group"
  }
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier     = "lab-wordpress-aurora-cluster"
  engine                 = "aurora-mysql"
  engine_version         = "8.0.mysql_aurora.3.04.1"
  database_name          = var.db_name
  master_username        = var.db_username
  master_password        = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids = [var.db_security_group_id]
  skip_final_snapshot    = true
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  count              = 1
  identifier         = "lab-wordpress-aurora-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.aurora_cluster.engine
  engine_version     = aws_rds_cluster.aurora_cluster.engine_version
}
