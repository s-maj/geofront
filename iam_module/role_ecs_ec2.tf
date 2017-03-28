resource "aws_iam_role" "ecs-ec2" {
  name = "ecs-ec2"
  assume_role_policy = "${data.template_file.ec2_profile_policy.rendered}"
}

resource "aws_iam_instance_profile" "ecs-ec2" {
  name  = "ecs-ec2"
  roles = ["${aws_iam_role.ecs-ec2.id}"]
}
