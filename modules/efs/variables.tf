variable "vpc_id" {}

variable "private_subnets_ids" {
  type = list(string)
}

variable "name" {
  type    = string
  default = "lab-efs"
}

variable "efs_sg" {
  type = string
}
