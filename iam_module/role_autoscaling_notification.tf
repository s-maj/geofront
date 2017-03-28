resource "aws_iam_role" "autoscaling_notification" {
  name = "autoscaling-notification"
  assume_role_policy = "${data.template_file.asg_profile_policy.rendered}"
}

resource "aws_iam_instance_profile" "autoscaling_notification" {
  name  = "autoscaling-notification"
  roles = ["${aws_iam_role.asg_role.id}"]
}
