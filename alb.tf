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