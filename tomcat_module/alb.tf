resource "aws_alb" "main" {
  name            = "${var.name}-alb"
  subnets         = ["${var.subnet_list_id}"]
  security_groups = ["${aws_security_group.alb_sg.id}"]
  internal        = true
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
  load_balancer_arn = "${aws_alb.main.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.http.id}"
    type             = "forward"
  }
}

resource "aws_route53_record" "record" {
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = "${data.aws_route53_zone.zone.name}"
  type    = "A"

  alias {
    name                   = "${data.aws_route53_zone.zone.zone_id}"
    zone_id                = "${data.aws_route53_zone.zone.name}"
    evaluate_target_health = true
  }
}
