data "template_file" "ecs_task_tomcat_policy" {
  template = "${file("${path.module}/policy/ecs_task_tomcat_policy.json")}"
}

resource "aws_iam_role" "ecs_task_tomcat" {
  name               = "ecs-task-tomcat"
  assume_role_policy = "${data.template_file.ecs_tasks_profile.rendered}"
}

resource "aws_iam_instance_profile" "ecs_task_tomcat" {
  name  = "ecs-task-tomcat"
  roles = ["${aws_iam_role.ecs_task_tomcat.id}"]
}

resource "aws_iam_role_policy" "ecs_task_tomcat" {
  role   = "${aws_iam_role.ecs_task_tomcat.id}"
  policy = "${data.template_file.ecs_task_tomcat_policy.rendered}"
}
