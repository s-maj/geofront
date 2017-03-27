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
  asg_min                 = 3
  asg_max                 = 12
  metric_name             = "MemoryReservation"
  adjustment_type         = "PercentChangeInCapacity"
  period                  = 60
  evaluation_periods      = 1
  scale_in_threshold      = 20
  scale_out_threshold     = 80
  scaling_adjustment      = 5
}
