resource "aws_alb" "main" {
  name            = "${var.name}-alb"
  subnets         = ["${var.subnet_list_id}"]
  security_groups = ["${aws_security_group.alb_sg.id}"]
  internal        = "${var.is_alb_internal}"
}

resource "aws_alb_target_group" "http" {
  name                  = "${var.name}-http"
  deregistration_delay  = 30
  port                  = 8080
  protocol              = "HTTP"
  vpc_id                = "${var.vpc_id}"

  health_check {
    path = "/"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = "${aws_alb.main.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.http.arn}"
    type             = "forward"
  }
}
