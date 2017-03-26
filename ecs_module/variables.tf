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

variable "asg_desired" {
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
