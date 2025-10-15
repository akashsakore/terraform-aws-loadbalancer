variable "security_groups" {}
variable "target_group_arn" {}
variable "target_id" {}
variable "public_subnet_id" {}

resource "aws_lb" "application-LB" {
  name               = "application-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.public_subnet_id
  enable_deletion_protection = false

  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_target_group_attachment" "application-LB-attachment" {
  target_group_arn = var.target_group_arn
  target_id        = var.target_id
  port             = 8080
}

#resource "aws_lb_listener" "https" {
#  load_balancer_arn = aws_lb.application_LB.arn
#  port              = "443"
#  default_action {
#    type             = "forward"
#    target_group_arn = var.target_group_arn
#  }
#}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.application-LB.arn
  port              = "80"
  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}
