module "tomcat" {
  source = "./tomcat_module"

  vpc_id              = "${module.geofront-eu-west-1.id}"
  ecs_sg_id           = "${module.ecs_cluster.sg_id}"
  ecs_cluster_name    = "${module.ecs_cluster.cluster_name}"
  subnet_list_id      = "${module.ecs_cluster.subnet_list_id}"
  region              = "${module.ecs_cluster.region}"
  name                = "tomcat-server"
  dns_zone            = "ganeti.pl"
  elb_dns_name        = "tomcat.ganeti.pl"
  container_version   = "tomcat:8.5"
  adjustment_type     = "PercentChangeInCapacity"
  metric_name         = "CPUUtilization"
  containers_desired  = 6
  containers_min      = 2
  containers_max      = 18
  cooldown            = 15
  period              = 60
  evaluation_periods  = 1
  scale_in_threshold  = 20
  scale_out_threshold = 80
  scaling_adjustment  = 5

}
