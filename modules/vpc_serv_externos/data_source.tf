data "aws_region" "this" {
  provider = aws.env
}

data "aws_caller_identity" "this" {
  provider = aws.env
}