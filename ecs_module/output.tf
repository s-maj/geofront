output "cluster_id" {
  value = "${aws_ecs_cluster.ecs.id}"
}

output "sg_id" {
  value = "${aws_security_group.ecs_sg.id}"
}

output "asg_name" {
  value = "${aws_autoscaling_group.ecs.name}"
}

output "region" {
  value = "${var.region}"
}
