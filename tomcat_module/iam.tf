resource "aws_iam_role" "container_role" {
  name               = "${var.name}-container"
  assume_role_policy = "${data.template_file.container_profile.rendered}"
}

resource "aws_iam_instance_profile" "container_profile" {
  name  = "${var.name}-container"
  roles = ["${aws_iam_role.container_role.id}"]
}

resource "aws_iam_role_policy" "container_role_policy" {
  name   = "${var.name}-container"
  role   = "${aws_iam_role.container_role.id}"
  policy = "${data.template_file.container_policy.rendered}"
}

resource "aws_iam_role" "service_role" {
  name               = "${var.name}-service"
  assume_role_policy = "${data.template_file.service_profile.rendered}"
}

resource "aws_iam_instance_profile" "service_profile" {
  name  = "${var.name}-service"
  roles = ["${aws_iam_role.container_role.id}"]
}

resource "aws_iam_policy_attachment" "service-policy-attach" {
    name       = "${var.name}-service"
    roles      = ["${aws_iam_role.service_role.id}"]
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
