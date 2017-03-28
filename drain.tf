module "lambda_drain" {
  source = "./ecs_drain_module"

  name   = "lambda-ecs-container-drain"
  region = "eu-west-1"
  role_arn = "${module.iam_security.ecs_drain_role_arn}"
}
