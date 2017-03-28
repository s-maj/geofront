output "ecs_autoscale_role_arn" {
  value = "${aws_iam_role.ecs_autoscale.arn}"
}

output "autoscaling_notification_role_arn" {
  value = "${aws_iam_role.autoscaling_notification.arn}"
}

output "ecs_service_role_arn" {
  value = "${aws_iam_role.ecs_service.arn}"
}

output "ecs_drain_role_arn" {
  value = "${aws_iam_role.ecs_drain.arn}"
}

output "ecs_ec2_profile_id" {
  value = "${aws_iam_instance_profile.ecs_ec2.id}"
}

output "ecs_task_tomcat_role_arn" {
  value = "${aws_iam_role.ecs_task_tomcat.arn}"
}
