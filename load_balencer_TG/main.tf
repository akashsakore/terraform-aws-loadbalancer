variable "my_vpc_id" {}
variable "port" {}
variable "protocol" {}
variable "ec2_instance_id" {}

output "target_group_arn" {
  value = aws_lb_target_group.my-lb-tg.arn
}

resource "aws_lb_target_group" "my-lb-tg" {
  name     = "my-lb-tg"
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.my_vpc_id
  health_check {
    healthy_threshold = 3
    interval = "30"
    matcher = "200"
    path = "/login"
    port = var.port
    protocol = "HTTP"
    timeout = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.my-lb-tg.arn
  target_id        = var.ec2_instance_id
  port             = var.port
}
