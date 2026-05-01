variable "name" {}
variable "ami_id" {}
variable "instance_type" {}
variable "private_subnets" {
  type = list(string)
}
variable "web_sg" {}
variable "target_group_arn" {}
variable "user_data" {}