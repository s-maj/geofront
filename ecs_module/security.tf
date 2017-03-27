resource "aws_security_group" "ecs_sg" {
  name    = "${var.name}-sg"
  vpc_id  = "${var.vpc_id}"
}

resource "aws_security_group_rule" "ecs_ssh_access" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = "${var.ssh_access_subnet_list}"
  security_group_id = "${aws_security_group.ecs_sg.id}"
}

resource "aws_security_group_rule" "ecs_sg_egress" {
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "all"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ecs_sg.id}"
}
