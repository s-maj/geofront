resource "aws_iam_role" "lambda_role" {
  name               = "${var.name}-role"
  assume_role_policy = "${data.template_file.lambda_profile.rendered}"
}

resource "aws_iam_instance_profile" "lambda_profile" {
  name  = "${var.name}-profile"
  roles = ["${aws_iam_role.lambda_role.id}"]
}

resource "aws_iam_role_policy" "lambda_policy" {
  role   = "${aws_iam_role.lambda_role.id}"
  policy = "${data.template_file.lambda_policy.rendered}"
}
