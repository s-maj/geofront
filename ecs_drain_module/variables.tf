variable "name" {
  type    = "string"
  default = "lambda-drain"
}

variable "role_arn" {
  type    = "string"
}

variable "region" {
  type    = "string"
  default = "eu-west-1"
}
