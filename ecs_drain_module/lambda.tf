resource "aws_lambda_function" "ecs_drain_lambda" {
  function_name    = "${var.name}"
  role             = "${var.role_arn}"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  filename         = "${data.archive_file.lambda_zip.output_path}"
  handler          = "index.lambda_handler"
  runtime          = "python2.7"
  timeout          = 300
  memory_size      = 128
  publish          = true
}

resource "aws_sns_topic" "sns" {
  name = "${var.name}-sns"
}

resource "aws_lambda_permission" "lambda_sns" {
  function_name = "${aws_lambda_function.ecs_drain_lambda.arn}"
  source_arn    = "${aws_sns_topic.sns.arn}"
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  principal     = "sns.amazonaws.com"
}

resource "aws_sns_topic_subscription" "lambda_subscribe" {
  topic_arn = "${aws_sns_topic.sns.arn}"
  endpoint  = "${aws_lambda_function.ecs_drain_lambda.arn}"
  protocol  = "lambda"
}
