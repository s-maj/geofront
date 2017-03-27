resource "aws_lambda_function" "ecs_drain_lambda" {
  role             = "${aws_iam_role.lambda_role.arn}"
  source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  filename         = "lambda_function_payload.zip"
  function_name    = "LambdaFunctionForASG"
  handler          = "index.lambda_handler"
  timeout          = 300
  memory_size      = 256
}

resource "aws_sns_topic" "sns" {
  name = "ECS-drain-sns"
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
