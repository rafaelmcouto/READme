resource "aws_secretsmanager_secret" "example" {
  name = var.name
  description = var.description
  tags = merge(
    var.tags_shared,
    tomap({
      "Service" = "Secrets Manager"
    })
  )  
}

resource "aws_secretsmanager_secret_policy" "example" {
  secret_arn = aws_secretsmanager_secret.example.arn

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EnableAllPermissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "secretsmanager:GetSecretValue",
      "Resource": "*"
    }
  ]
}
POLICY
}

resource "aws_secretsmanager_secret_version" "secret_value" {
  secret_id     = aws_secretsmanager_secret.example.id
  secret_string = random_password.password.result
}

resource "random_password" "password" {
  length           = 16
  special          = false
}

data "aws_secretsmanager_secret" "example" {
  name = aws_secretsmanager_secret.example.name
}

data "aws_secretsmanager_secret_version" "example" {
  secret_id = data.aws_secretsmanager_secret.example.id
}

data "aws_secretsmanager_secret_version" "by-version-stage" {
  secret_id     = data.aws_secretsmanager_secret.example.id
}