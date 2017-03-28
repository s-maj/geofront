output "ecs_drain_role_arn" {
  value = "${aws_iam_role.ecs_drain.arn}"
}

output "ecs_ec2_profile_id" {
  value = "${aws_iam_instance_profile.ecs_ec2.id}"
}

output "autoscaling_notification_role_arn" {
  value = "${aws_iam_role.autoscaling_notification.arn}"
}
