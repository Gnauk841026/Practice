resource "aws_lb" "nlb4private" {
  name               = "nlb-for-private-subnets"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [module.vpc.default_security_group_id]
  subnets            = module.vpc.private_subnets

  tags = {
    Environment = var.environment
  }

}

resource "aws_lb_target_group" "nlb4private-instance" {
  name     = "nlb4private-instance"
  port     = 22
  protocol = "TCP"
  vpc_id   = module.vpc.vpc_id
  target_type = "instance"

    health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

resource "aws_lb_listener" "nlb4private-listener" {
  load_balancer_arn = aws_lb.nlb4private.arn
  port              = 22
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb4private-instance.arn
  }
}
