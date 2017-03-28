data "template_file" "ecs_drain_policy" {
  template = "${file("${path.module}/policies/ecs_drain_policy.json")}"
}

resource "aws_iam_role" "ecs_drain" {
  name               = "ecs_drain"
  assume_role_policy = "${data.template_file.lambda_profile.rendered}"
}

resource "aws_iam_role_policy" "ecs_drain" {
  name   = "ecs_drain"
  role   = "${aws_iam_role.ecs_drain.id}"
  policy = "${data.template_file.ecs_drain_policy.rendered}"
}

resource "aws_iam_instance_profile" "ecs_drain" {
  name  = "ecs_drain"
  roles = ["${aws_iam_role.ecs_drain.id}"]
}
