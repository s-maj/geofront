resource "aws_ecs_service" "tomcat" {
  name                               = "${var.name}"
  cluster                            = "${var.ecs_cluster_id}"
  desired_count                      = "${var.container_count}"
  task_definition                    = "${aws_ecs_task_definition.tomcat.arn}"
  iam_role                           = "${aws_iam_role.service_role.arn}"
  depends_on                         = ["aws_iam_role.service_role"]
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 67

  load_balancer {
    target_group_arn = "${aws_alb_target_group.consul_api.id}"
    container_name = "${var.name}"
    container_port = 8080
  }
}

resource "aws_ecs_task_definition" "tomcat" {
  family                = "${var.name}"
  container_definitions = "${data.template_file.task_definition.rendered}"
  task_role_arn         = "${aws_iam_role.container_role.arn}"
  network_mode          = "bridge"
}
