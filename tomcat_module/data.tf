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

data "template_file" "container_profile" {
  template = "${file("${path.module}/templates/container_profile.json")}"
}

data "template_file" "container_policy" {
  template = "${file("${path.module}/templates/container_policy.json")}"
}

data "template_file" "service_profile" {
  template = "${file("${path.module}/templates/service_profile.json")}"
}

data "template_file" "app_scale_profile" {
  template = "${file("${path.module}/templates/app_scale_profile.json")}"
}
