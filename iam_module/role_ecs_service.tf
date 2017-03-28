resource "aws_iam_role" "ecs_service" {
  name               = "ecs-service"
  assume_role_policy = "${data.template_file.ecs_profile.rendered}"
}

resource "aws_iam_instance_profile" "ecs_service" {
  name  = "ecs-service"
  roles = ["${aws_iam_role.ecs_service.id}"]
}

resource "aws_iam_role_policy_attachment" "ecs_service_policy_attach" {
  role       = "${aws_iam_role.ecs_service.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
