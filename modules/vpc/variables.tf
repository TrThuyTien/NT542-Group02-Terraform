variable "vpc_cidr" {}
variable "public_subnets" { type = list(string) }
variable "private_app_subnets" { type = list(string) }
variable "private_data_subnets" { type = list(string) }
variable "azs" { type = list(string) }
