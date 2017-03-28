resource "aws_iam_role" "ecs_service" {
  name               = "${var.name}-service"
  assume_role_policy = "${data.template_file.ecs_profile.rendered}"
}

resource "aws_iam_instance_profile" "ecs_service" {
  name  = "ecs-service"
  roles = ["${aws_iam_role.container_role.id}"]
}
