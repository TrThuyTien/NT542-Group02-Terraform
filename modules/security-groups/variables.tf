variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "Allowed IP for SSH access to bastion"
  type        = string
  default     = "0.0.0.0/0"  # hoặc IP của bạn (an toàn hơn)
}

variable "alb_sg" {
  description = "ALB Security Group (optional)"
  type        = string
  default     = null
}
