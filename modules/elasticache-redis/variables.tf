variable "private_data_subnet_ids" {
  description = "Danh sách ID của các private subnet dành cho Data Layer"
  type        = list(string)
}

variable "redis_security_group_id" {
  description = "ID của Security Group dành cho Redis"
  type        = string
}
