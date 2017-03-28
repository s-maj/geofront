resource "aws_iam_role" "ecs_autoscale" {
  name               = "ecs_autoscale"
  assume_role_policy = "${data.template_file.app_autoscaling_profile.rendered}"
}

resource "aws_iam_instance_profile" "ecs_autoscale" {
  name  = "ecs_autoscale"
  roles = ["${aws_iam_role.ecs_autoscale.id}"]
}
