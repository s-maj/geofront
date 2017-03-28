data "template_file" "task_definition" {
  template = "${file("${path.module}/templates/tomcat-task.json")}"
  vars {
    container_name    = "${var.name}"
    container_version = "${var.container_version}"
  }
}

data "aws_ecs_cluster" "ecs" {
  cluster_name = "${var.ecs_cluster_name}"
}

data "aws_route53_zone" "zone" {
  name         = "${var.dns_zone}."
  private_zone = "${var.is_dns_zone_private}"
}
