resource "aws_iam_policy_attachment" "ecs_service_policy_attach" {
  roles      = ["${aws_iam_role.ecs_service.id}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

resource "aws_iam_role_policy_attachment" "ecs-ec2-policy-attach" {
  role = "${aws_iam_role.ecs-ec2.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecr-ec2-policy-attach" {
  role = "${aws_iam_role.ecs-ec2.id}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "autoscaling_notification_policy_attach" {
  role = "${aws_iam_role.asg_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AutoScalingNotificationAccessRole"
}

resource "aws_iam_policy_attachment" "ecs_autoscale_policy_attach" {
  roles      = ["${aws_iam_role.ecs_autoscale.id}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}
