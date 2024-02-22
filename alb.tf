resource "aws_lb" "musicbox_alb" {
  name               = "external-musicbox"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.sg_fe
  subnets            = var.subnets
}


resource "aws_lb_target_group" "musicbox-tg" {
  name        = "musicbox-tg"
  port        = var.fe_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id
  health_check {
    path = "/health"
    port = var.fe_port
  }
}
resource "aws_lb_listener" "musicbox-listener" {
  load_balancer_arn = aws_lb.musicbox_alb.arn
  port              = var.fe_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.musicbox-tg.arn
  }
}
####################################################
resource "aws_lb" "musicbox_alb_vg" {
  name               = "external-musicbox-vg"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.sg_fe
  subnets            = var.subnets
}


resource "aws_lb_target_group" "musicbox-tg_vg" {
  name        = "musicbox-tg-vg"
  port = 80
  health_check{
    path = "/ready"
    port = 9901
  }
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id
}
resource "aws_lb_listener" "musicbox-listener_vg" {
  load_balancer_arn = aws_lb.musicbox_alb_vg.arn
  port              = 80

  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.musicbox-tg_vg.arn
  }
}