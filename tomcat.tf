module "consul" {
  source = "./tomcat_module"

  vpc_id              = "${module.geofront-eu-west-1.id}"
  ecs_sg_id           = "${module.ecs_cluster.cluster_sg_id}"
  ecs_cluster_id      = "${module.ecs_cluster.cluster_id}"
  region              = "${module.ecs_cluster.region}"
  name                = "tomcat-server"
  dns_zone            = "ganeti.pl"
  container_version   = "tomcat:8.5"
  nodes_number        = 6
}
