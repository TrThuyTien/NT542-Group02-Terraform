resource "aws_launch_template" "this" {
  name_prefix   = var.name
  image_id      = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [var.web_sg]
  user_data = base64encode(var.user_data)

    tags = {
      Name = var.name
    }
}

resource "aws_autoscaling_group" "this" {
  name                      = var.name
  max_size                  = 4
  min_size                  = 2
  desired_capacity          = 2
  vpc_zone_identifier = var.private_subnets
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  target_group_arns         = [var.target_group_arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }
}