resource "aws_iam_role" "ecs_ec2" {
  name = "ecs-ec2"
  assume_role_policy = "${data.template_file.ec2_profile.rendered}"
}

resource "aws_iam_instance_profile" "ecs_ec2" {
  name  = "ecs-ec2"
  roles = ["${aws_iam_role.ecs_ec2.id}"]
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_policy_attach" {
  role       = "${aws_iam_role.ecs_ec2.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecr_ec2_policy_attach" {
  role       = "${aws_iam_role.ecs_ec2.id}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
