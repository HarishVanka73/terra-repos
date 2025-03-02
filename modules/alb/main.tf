

resource "aws_security_group" "alb-sg" {
  name   = "alb-sec-grp"
  vpc_id = var.vpc_id

  ingress {
    description = "allow http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #ingress {
    #description = "allow https"
    #from_port   = 443
    #to_port     = 443
    #protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
  #}

  egress {
    description = "allow outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [var.sec-grp-id]
  }
}

resource "aws_lb" "name-alb" {
  name               = "alb-2-tier"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = [var.public-sub-1-id, var.public-sub-2-id]
}
locals {
  engine = "${terraform.workspace}"
}
resource "aws_lb_target_group" "tg-alb" {
  name     = "target-grp"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  tags = {
    name = "${local.engine}-rds"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.name-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-alb.arn

  }
}