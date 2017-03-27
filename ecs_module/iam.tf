resource "aws_iam_role" "ec2_role" {
  name = "${var.name}-role"
  assume_role_policy = "${data.template_file.role_profile_policy.rendered}"
}

resource "aws_iam_instance_profile" "ec2_role_profile" {
  name  = "${var.name}-role-profile"
  roles = ["${aws_iam_role.ec2_role.id}"]
}

resource "aws_iam_role_policy_attachment" "ecs-policy-attach" {
    role = "${aws_iam_role.ec2_role.id}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecr-policy-attach" {
    role = "${aws_iam_role.ec2_role.id}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
