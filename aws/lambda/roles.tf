resource "aws_iam_role" "iam_for_lambda" {
  name = "__role_lambda_${split(".", var.function_name)[0]}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logging" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "__lambda_logging_${split(".", var.function_name)[0]}"
  path        = "/"
  description = "IAM policy for logging from lambda"

  policy = var.lambda_logging_policy
}

resource "aws_iam_role_policy_attachment" "lambda_vpc" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_vpc.arn
}

resource "aws_iam_policy" "lambda_vpc" {
  name        = "__lambda_vpc_${split(".", var.function_name)[0]}"
  path        = "/"
  description = "IAM policy for lambda"

  policy = var.lambda_vpc_policy
}
