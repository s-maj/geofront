variable "ecs_cluster_id" {
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

variable "is_dns_zone_private" {
  type    = "string"
  default = "fa;se"
}
