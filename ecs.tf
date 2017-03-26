module "ecs_cluster" {
  source = "./ecs_module"

  name                    = "geofront-ecs"
  region                  = "eu-west-1"
  instance_type           = "t2.micro"
  key_name                = "geofront"
  vpc_id                  = "${module.geofront-eu-west-1.id}"
  subnet_list_id          = "${module.geofront-eu-west-1.subnet_list}"
  ssh_access_subnet_list  = ["0.0.0.0/0"]
  asg_desired             = 3
  asg_min                 = 3
  asg_max                 = 3
}
