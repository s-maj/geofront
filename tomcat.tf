/*module "tomcat" {
  source = "./tomcat_module"

  vpc_id              = "${module.geofront-eu-west-1.id}"
  ecs_sg_id           = "${module.ecs_cluster.sg_id}"
  ecs_cluster_id      = "${module.ecs_cluster.cluster_id}"
  subnet_list_id      = "${module.ecs_cluster.subnet_list_id}"
  region              = "${module.ecs_cluster.region}"
  name                = "tomcat-server"
  dns_zone            = "ganeti.pl"
  elb_dns_name        = "tomcat.ganeti.pl"
  container_version   = "tomcat:8.5"
  container_count     = 2
}*/
