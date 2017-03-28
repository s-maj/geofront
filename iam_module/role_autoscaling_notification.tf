resource "aws_iam_role" "autoscaling_notification" {
  name = "autoscaling-notification"
  assume_role_policy = "${data.template_file.autoscaling_profile.rendered}"
}

resource "aws_iam_instance_profile" "autoscaling_notification" {
  name  = "autoscaling-notification"
  roles = ["${aws_iam_role.autoscaling_notification.id}"]
}

resource "aws_iam_role_policy_attachment" "autoscaling_notification_policy_attach" {
  role       = "${aws_iam_role.autoscaling_notification.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AutoScalingNotificationAccessRole"
}
