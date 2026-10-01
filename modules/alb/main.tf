resource "aws_lb" "alb_lb" {
  name               = "alb-load-balancer"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.public_subnet_1, var.public_subnet_2]
  security_groups = [ var.alb_security_group ]

  tags = {
    name = "ALB"
  }
  enable_deletion_protection = true
}

resource "aws_lb_target_group" "alb_target_group" {
  name     = "alb-listener"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb_lb.arn
  port              = "80"
  protocol          = "HTTP"
  

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = var.aws_instance
  port             = 80
}
