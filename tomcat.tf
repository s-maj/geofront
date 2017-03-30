module "tomcat" {
  source = "./tomcat_module"

  vpc_id                 = "${module.geofront-eu-west-1.id}"
  ecs_sg_id              = "${module.ecs_cluster.sg_id}"
  ecs_cluster_name       = "${module.ecs_cluster.cluster_name}"
  subnet_list_id         = "${module.ecs_cluster.subnet_list_id}"
  region                 = "${module.ecs_cluster.region}"
  ecs_service_role_arn   = "${module.iam_security.ecs_service_role_arn}"
  ecs_task_role_arn      = "${module.iam_security.ecs_task_tomcat_role_arn}"
  ecs_autoscale_role_arn = "${module.iam_security.ecs_autoscale_role_arn}"
  name                   = "tomcat-server"
  container_version      = "tomcat:8.5"
  adjustment_type        = "PercentChangeInCapacity"
  metric_name            = "CPUUtilization"
  containers_initial     = 6
  containers_min         = 1
  containers_max         = 18
  cooldown               = 15
  period                 = 60
  evaluation_periods     = 1
  scale_in_threshold     = 20
  scale_out_threshold    = 80
  scaling_adjustment     = 10
}
