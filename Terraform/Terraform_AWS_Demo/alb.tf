resource "aws_lb" "alb4public" {
  name               = "alb-for-public-subnets"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.vpc.default_security_group_id]
  subnets            = module.vpc.public_subnets

  tags = {
    Environment = var.environment
  }

}

resource "aws_lb_target_group" "alb4public-instance" {
  name     = "alb4public-instance"
  port     = 80
  protocol = "HTTP"
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

resource "aws_lb_listener" "alb4public-listener" {
  load_balancer_arn = aws_lb.alb4public.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb4public-instance.arn
  }
}
