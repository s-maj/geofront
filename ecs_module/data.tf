data "aws_ami" "ecs" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }

  filter {
    name  = "owner-alias"
    values = ["amazon"]
  }
}

data "template_file" "userdata" {
  template = "${file("${path.module}/templates/userdata.sh")}"
  vars {
    cluster_name = "${var.name}"
   }
}

data "template_file" "ec2_profile_policy" {
  template = "${file("${path.module}/templates/ec2_profile.json")}"
}

data "template_file" "asg_profile_policy" {
  template = "${file("${path.module}/templates/asg_profile.json")}"
}
