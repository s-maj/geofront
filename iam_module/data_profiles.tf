data "template_file" "ec2_profile" {
  template = "${file("${path.module}/profiles/ec2_profile.json")}"
}

data "template_file" "ecs_profile" {
  template = "${file("${path.module}/profiles/ecs_profile.json")}"
}

data "template_file" "ecs_tasks_profile" {
  template = "${file("${path.module}/profiles/ecs_tasks_profile.json")}"
}

data "template_file" "lambda_profile" {
  template = "${file("${path.module}/profiles/lambda_profile.json")}"
}

data "template_file" "autoscaling_profile" {
  template = "${file("${path.module}/profiles/autoscaling_profile.json")}"
}

data "template_file" "app_autoscaling_profile" {
  template = "${file("${path.module}/profiles/app_autoscaling_profile.json")}"
}
