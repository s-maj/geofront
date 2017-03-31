resource "aws_autoscaling_group" "ecs" {
  name                 = "${var.name}-asg"
  min_size             = "${var.asg_min}"
  max_size             = "${var.asg_max}"
  vpc_zone_identifier  = ["${var.subnet_list_id}"]
  launch_configuration = "${aws_launch_configuration.ecs.name}"
  force_delete         = true
  enabled_metrics      = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]

  lifecycle {
    create_before_destroy = true
  }

  initial_lifecycle_hook {
    name                    = "${var.name}-draining-hook"
    notification_target_arn = "${var.ecs_drain_sns_arn}"
    role_arn                = "${var.autoscaling_notification_role_arn}"
    default_result          = "CONTINUE"
    lifecycle_transition    = "autoscaling:EC2_INSTANCE_TERMINATING"
    default_result          = "ABANDON"
    heartbeat_timeout       = 900
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
  iam_instance_profile        = "${var.instance_profile_ecs_ec2_id}"
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
