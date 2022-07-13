variable "function_name" { type = string }
variable "method" { type = string }
variable "runtime" { type = string }
variable "timeout" { type = number }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(any) }

variable "description" {
  type    = string
  default = "A Lambda function"
}

variable "ingress" {
  type = list(object({
    description      = string
    from_port        = number
    to_port          = number
    protocol         = string
    security_groups = list(string)
  }))
  default = []
}

variable "tags" {
  type = map(string)
  default = {
    "Service" = "Lambda"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}

variable "lambda_vpc_policy" {
  default = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
              "ec2:CreateNetworkInterface",
              "ec2:DescribeNetworkInterfaces",
              "ec2:DeleteNetworkInterface",
              "ec2:DescribeSecurityGroups",
              "ec2:DescribeSubnets",
              "ec2:DescribeVpcs",
              "ec2:Stop*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
EOF
}

variable "lambda_logging_policy" {
  default = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*",
            "Effect": "Allow"
        }
    ]
}
EOF
}
