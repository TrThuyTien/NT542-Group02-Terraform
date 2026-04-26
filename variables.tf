variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "public_subnets" {
  default = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "private_app_subnets" {
  default = ["10.10.11.0/24", "10.10.12.0/24"]
}

variable "private_data_subnets" {
  default = ["10.10.21.0/24", "10.10.22.0/24"]
}

variable "azs" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "key_name" {
  type = string
}

variable "ami_id" {
  type        = string
  description = "Ubuntu Server 22.04 LTS (HVM),EBS General Purpose (SSD) Volume Type."
  default     = "ami-04680790a315cd58d"
}

variable "db_name" {
  description = "Tên database"
  type        = string
  default     = "wordpressdb"
}

variable "db_username" {
  description = "Tên đăng nhập database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Mật khẩu database"
  type        = string
  sensitive   = true
}