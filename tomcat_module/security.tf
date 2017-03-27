resource "aws_security_group" "alb_sg" {
  name    = "${var.name}-alb-sg"
  vpc_id  = "${var.vpc_id}"
}

resource "aws_security_group_rule" "alb_http_access" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.alb_sg.id}"
}

resource "aws_security_group_rule" "alb_https_access" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.alb_sg.id}"
}

resource "aws_security_group_rule" "alb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.alb_sg.id}"
}
