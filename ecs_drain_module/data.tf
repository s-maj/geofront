data "archive_file" "lambda_zip" {
    type        = "zip"
    source_file  = "${path.module}/templates/index.py"
    output_path = ".terraform/lambda.zip"
}

data "template_file" "lambda_profile" {
  template = "${file("${path.module}/templates/profile.json")}"
}
