output "ecs_drain_role_arn" {
  value = "${aws_iam_role.ecs_drain.arn}"
}
