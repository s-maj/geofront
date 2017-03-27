variable "ecs_cluster_name" {
  type    = "string"
}

variable "container_version" {
  type    = "string"
  default = "consul:0.7.2"
}

variable "name" {
  type    = "string"
}

variable "vpc_id" {
  type    = "string"
}

variable "subnet_list_id" {
  type    = "list"
}

variable "ecs_sg_id" {
  type    = "string"
}

variable "dns_zone" {
  type    = "string"
}

variable "elb_dns_name" {
  type    = "string"
}

variable "is_dns_zone_private" {
  type    = "string"
  default = "false"
}

variable "is_alb_internal" {
  type    = "string"
  default = "false"
}

variable "region" {
  type    = "string"
  default = "eu-west-1"
}

variable "containers_desired" {
  type    = "string"
  default = "6"
}

variable "containers_min" {
  type    = "string"
  default = "2"
}

variable "containers_max" {
  type    = "string"
  default = "12"
}

variable "cooldown" {
  type    = "string"
  default = "60"
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

variable "evaluation_periods" {
  type    = "string"
}

variable "scale_in_threshold" {
  type    = "string"
}

variable "scale_out_threshold" {
  type    = "string"
}

variable "statistic" {
  type    = "string"
  default = "Average"
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

variable "adjustment_type" {
  type    = "string"
}

variable "metric_aggregation_type" {
  type    = "string"
  default = "Average"
}

variable "scalable_dimension" {
  type    = "string"
  default = "ecs:service:DesiredCount"
}

variable "scaling_adjustment" {
  type    = "string"
}
