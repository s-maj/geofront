resource "aws_autoscaling_group" "ecs" {
  name                 = "${var.name}-asg"
  min_size             = "${var.asg_min}"
  max_size             = "${var.asg_max}"
  vpc_zone_identifier  = ["${var.subnet_list_id}"]
  launch_configuration = "${aws_launch_configuration.ecs.name}"
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

resource "aws_autoscaling_policy" "scale_out" {
  policy_type               = "StepScaling"
  name                      = "${var.name}-asg-policy-scale-out"
  adjustment_type           = "${var.adjustment_type}"
  estimated_instance_warmup = "${var.warmup}"
  autoscaling_group_name    = "${aws_autoscaling_group.ecs.name}"

  step_adjustment {
    scaling_adjustment   = "${var.scaling_adjustment}"
    metric_interval_lower_bound = 0
  }
}

resource "aws_autoscaling_policy" "scale_in" {
  policy_type            = "StepScaling"
  name                   = "${var.name}-asg-policy-scale-in"
  adjustment_type        = "${var.adjustment_type}"
  autoscaling_group_name = "${aws_autoscaling_group.ecs.name}"

  step_adjustment {
    scaling_adjustment   = "-${var.scaling_adjustment}"
    metric_interval_upper_bound = 0
  }
}

resource "aws_cloudwatch_metric_alarm" "scale_out" {
  actions_enabled     = true
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_actions       = ["${aws_autoscaling_policy.scale_out.arn}"]
  alarm_description   = "${var.name} ASG Alarm"
  alarm_name          = "${var.name}-asg-scale_out"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.ecs.id}"
  }

  evaluation_periods = "${var.evaluation_periods}"
  metric_name        = "${var.metric_name}"
  namespace          = "${var.name_space}"
  period             = "${var.period}"
  threshold          = "${var.threshold}"
  statistic          = "${lookup(var.valid_statistics, var.statistic)}"
}

resource "aws_cloudwatch_metric_alarm" "scale_in" {
  actions_enabled     = true
  comparison_operator = "LessThanOrEqualToThreshold"
  alarm_actions       = ["${aws_autoscaling_policy.scale_in.arn}"]
  alarm_description   = "${var.name} ASG Alarm"
  alarm_name          = "${var.name}-asg-scale_in"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.ecs.id}"
  }

  evaluation_periods = "${var.evaluation_periods}"
  metric_name        = "${var.metric_name}"
  namespace          = "${var.name_space}"
  period             = "${var.period}"
  threshold          = "${var.threshold}"
  statistic          = "${lookup(var.valid_statistics, var.statistic)}"
}
