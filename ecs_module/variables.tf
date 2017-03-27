variable "name" {
  type    = "string"
}

variable "key_name" {
  type    = "string"
}

variable "instance_type" {
  type    = "string"
}

variable "vpc_id" {
  type    = "string"
}

variable "subnet_list_id" {
  type    = "list"
}

variable "asg_min" {
  type    = "string"
}

variable "asg_max" {
  type    = "string"
}

variable "ssh_access_subnet_list" {
  type    = "list"
  default = ["10.0.0.0/8"]
}

variable "region" {
  type    = "string"
  default = "eu-west-1"
}

variable "adjustment_type" {
  type    = "string"
}

variable "evaluation_periods" {
  type    = "string"
}

variable "metric_name" {
  type    = "string"
}

variable "name_space" {
  type    = "string"
  default = "AWS/ECS"
}

variable "period" {
  type    = "string"
}

variable "statistic" {
  type    = "string"
  default = "Average"
}

variable "scale_in_threshold" {
  type    = "string"
}

variable "scale_out_threshold" {
  type    = "string"
}

variable "warmup" {
  type    = "string"
  default = "120"
}

variable "valid_statistics" {
  type = "map"

  default = {
    Average     = "Average"
    Maximum     = "Maximum"
    Minimum     = "Minimum"
    SampleCount = "SampleCount"
    Sum         = "Sum"
  }
}

variable "scaling_adjustment" {
  type    = "string"
}

variable "sns_lambda_drain" {
  type    = "string"
}
