resource "aws_autoscaling_group" "ecs" {
  name                 = "${var.name}-asg"
  min_size             = "${var.asg_min}"
  max_size             = "${var.asg_max}"
  desired_capacity     = "${var.asg_desired}"
  vpc_zone_identifier  = ["${var.subnet_list_id}"]
  launch_configuration = "${aws_launch_configuration.ecs.name}"

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name}"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "ecs" {
  key_name                    = "${var.key_name}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${aws_iam_instance_profile.ec2_role_profile.id}"
  image_id                    = "${data.aws_ami.ecs.id}"
  user_data                   = "${data.template_file.userdata.rendered}"
  security_groups             = ["${aws_security_group.ecs_sg.id}"]

  root_block_device {
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
