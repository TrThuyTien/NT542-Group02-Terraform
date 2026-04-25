variable "vpc_id" {}
variable "public_subnet_id" {}
variable "key_name" {}
variable "ami_id" {}

variable "efs_dns" {}


variable "instance_type" {
  default = "t2.micro"
}

variable "sg_web_public" {}