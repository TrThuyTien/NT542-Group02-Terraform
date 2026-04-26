variable "private_data_subnet_ids" {
  description = "Danh sách ID của các private subnet dành cho Data Layer từ VPC"
  type        = list(string)
}

variable "db_security_group_id" {
  description = "ID của Security Group dành cho Database"
  type        = string
}

variable "db_name" {
  description = "Tên của database WordPress"
  type        = string
  default     = "wordpressdb"
}

variable "db_username" {
  description = "Username admin của database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Mật khẩu admin của database"
  type        = string
  sensitive   = true
}
