output "cluster_id" {
  value = "${aws_ecs_cluster.ecs.id}"
}

output "cluster_sg_id" {
  value = "${aws_security_group.ecs_sg.id}"
}
