resource "aws_lambda_function" "default" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = split(".", var.function_name)[0]
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "${split(".", var.function_name)[0]}.${var.method}"
  description   = var.description
  runtime       = var.runtime
  timeout       = var.timeout

  vpc_config {
    subnet_ids         = [element(var.subnet_ids, 0)]
    security_group_ids = [aws_security_group.default.id]
  }

  tags = merge(
    var.tags_shared,
    tomap({
      "Service" = "Lambda"
    })
  )
}

resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/${split(".", var.function_name)[0]}"
  retention_in_days = 5
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/code/${var.function_name}"
  output_path = "${path.module}/code/app.zip"
}