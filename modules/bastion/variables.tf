variable "vpc_id" {}
variable "public_subnet_id" {}
variable "key_name" {}
variable "ami_id" {}
variable "instance_type" {
  default = "t2.micro"
}
variable "bastion_sg" {
}