resource "aws_iam_role" "ecs-ec2" {
  name = "ecs-ec2"
  assume_role_policy = "${data.template_file.ec2_profile.rendered}"
}

resource "aws_iam_instance_profile" "ecs-ec2" {
  name  = "ecs-ec2"
  roles = ["${aws_iam_role.ecs-ec2.id}"]
}

resource "aws_iam_role_policy_attachment" "ecs-ec2-policy-attach" {
  role       = "${aws_iam_role.ecs-ec2.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecr-ec2-policy-attach" {
  role       = "${aws_iam_role.ecs-ec2.id}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
