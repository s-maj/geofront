module "ecs_cluster" {
  source = "./ecs_module"

  vpc_id                  = "${module.geofront-eu-west-1.id}"
  subnet_list_id          = "${module.geofront-eu-west-1.subnet_list}"
  sns_lambda_drain        = "${module.lambda_drain.sns_arn}"
  name                    = "geofront-ecs"
  region                  = "eu-west-1"
  instance_type           = "t2.micro"
  key_name                = "geofront"
  ssh_access_subnet_list  = [ "0.0.0.0/0" ]
  asg_min                 = 1
  asg_max                 = 12
  adjustment_type         = "PercentChangeInCapacity"
  metric_name             = "CPUUtilization"
  period                  = 60
  evaluation_periods      = 1
  threshold               = 20
  scaling_adjustment      = 5
}
