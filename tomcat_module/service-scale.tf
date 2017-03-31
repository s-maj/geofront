resource "aws_appautoscaling_target" "ecs_target" {
  role_arn           = "${var.ecs_autoscale_role_arn}"
  scalable_dimension = "${var.scalable_dimension}"
  resource_id        = "service/${var.ecs_cluster_name}/${var.name}"
  service_namespace  = "ecs"
  max_capacity       = "${var.containers_max}"
  min_capacity       = "${var.containers_min}"

  depends_on = ["aws_ecs_service.tomcat"]
}

resource "aws_appautoscaling_policy" "scale_out" {
  name                    = "${var.name}-ecs-policy-scale-out"
  adjustment_type         = "${var.adjustment_type}"
  metric_aggregation_type = "${var.metric_aggregation_type}"
  scalable_dimension      = "${var.scalable_dimension}"
  cooldown                = "${var.cooldown}"
  resource_id             = "service/${var.ecs_cluster_name}/${var.name}"
  policy_type             = "StepScaling"
  service_namespace       = "ecs"

  step_adjustment {
    scaling_adjustment          = "${var.scaling_adjustment}"
    metric_interval_lower_bound = 0
  }

  depends_on = ["aws_appautoscaling_target.ecs_target"]
}

resource "aws_appautoscaling_policy" "scale_in" {
  name                    = "${var.name}-ecs-policy-scale-in"
  adjustment_type         = "${var.adjustment_type}"
  metric_aggregation_type = "${var.metric_aggregation_type}"
  scalable_dimension      = "${var.scalable_dimension}"
  cooldown                = "${var.cooldown}"
  resource_id             = "service/${var.ecs_cluster_name}/${var.name}"
  policy_type             = "StepScaling"
  service_namespace       = "ecs"

  step_adjustment {
    scaling_adjustment          = "-${var.scaling_adjustment}"
    metric_interval_upper_bound = 0
  }

  depends_on = ["aws_appautoscaling_target.ecs_target"]
}

resource "aws_cloudwatch_metric_alarm" "scale_out" {
  actions_enabled     = true
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_actions       = ["${aws_appautoscaling_policy.scale_out.arn}"]
  alarm_description   = "${var.name} ECS Alarm"
  alarm_name          = "${var.name}-asg-scale-out"

  dimensions = {
    "ClusterName" = "${var.ecs_cluster_name}",
    "ServiceName" = "${var.name}"
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
  alarm_actions       = ["${aws_appautoscaling_policy.scale_in.arn}"]
  alarm_description   = "${var.name} ECS Alarm"
  alarm_name          = "${var.name}-asg-scale-in"

  dimensions = {
    "ClusterName" = "${var.ecs_cluster_name}",
    "ServiceName" = "${var.name}"
  }

  evaluation_periods = "${var.evaluation_periods}"
  metric_name        = "${var.metric_name}"
  namespace          = "${var.name_space}"
  period             = "${var.period}"
  threshold          = "${var.scale_in_threshold}"
  statistic          = "${lookup(var.valid_statistics, var.statistic)}"
}
