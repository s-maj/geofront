resource "aws_ecs_service" "tomcat" {
  name                               = "${var.name}"
  desired_count                      = "${var.containers_desired}"
  cluster                            = "${data.aws_ecs_cluster.ecs.id}"
  task_definition                    = "${aws_ecs_task_definition.tomcat.arn}"
  iam_role                           = "${aws_iam_role.service_role.arn}"
  depends_on                         = ["aws_iam_role.service_role", "aws_alb_target_group.http"]
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100

  placement_strategy {
    field = "cpu"
    type  = "binpack"
  }

  placement_strategy {
    field = "attribute:ecs.availability-zone"
    type  = "spread"
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.http.id}"
    container_name   = "${var.name}"
    container_port   = 8080
  }
}

resource "aws_ecs_task_definition" "tomcat" {
  family                = "${var.name}"
  container_definitions = "${data.template_file.task_definition.rendered}"
  task_role_arn         = "${aws_iam_role.container_role.arn}"
  network_mode          = "bridge"
}
