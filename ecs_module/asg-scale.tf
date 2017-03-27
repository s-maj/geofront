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
  alarm_name          = "${var.name}-asg-scale-out"

  dimensions = {
    "ClusterName" = "${var.name}"
  }

  evaluation_periods = "${var.evaluation_periods}"
  metric_name        = "${var.metric_name}"
  namespace          = "${var.name_space}"
  period             = "${var.period}"
  threshold          = "${var.scale_out_threshold}"
  statistic          = "${lookup(var.valid_statistics, var.statistic)}"
}

resource "aws_cloudwatch_metric_alarm" "scale_in" {
  actions_enabled     = true
  comparison_operator = "LessThanOrEqualToThreshold"
  alarm_actions       = ["${aws_autoscaling_policy.scale_in.arn}"]
  alarm_description   = "${var.name} ASG Alarm"
  alarm_name          = "${var.name}-asg-scale-in"

  dimensions = {
    "ClusterName" = "${var.name}"
  }

  evaluation_periods = "${var.evaluation_periods}"
  metric_name        = "${var.metric_name}"
  namespace          = "${var.name_space}"
  period             = "${var.period}"
  threshold          = "${var.scale_in_threshold}"
  statistic          = "${lookup(var.valid_statistics, var.statistic)}"
}
