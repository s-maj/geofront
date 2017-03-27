module "lambda_drain" {
  source = "./ecs_drain_module"

  name = "lambda-asg-container-drain"
}
