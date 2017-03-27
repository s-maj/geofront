resource "aws_iam_role" "lambda_role" {
  name = "${var.name}-role"
  assume_role_policy = "${data.template_file.ec2_profile_policy.rendered}"
}

resource "aws_iam_instance_profile" "lambda_profile" {
  name  = "${var.name}-profile"
  roles = ["${aws_iam_role.lambda_role.id}"]
}

resource "aws_iam_role_policy_attachment" "autoscaling-notification-policy-attach" {
    role = "${aws_iam_role.lambda_role.id}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AutoScalingNotificationAccessRole"
}
