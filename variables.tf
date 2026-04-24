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
