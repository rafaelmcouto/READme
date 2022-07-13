resource "aws_iam_role" "default" {
  name = "SessionManagerEC2${local.name}"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "default" {
  name = "InstanceProfileSSM${local.name}"
  role = aws_iam_role.default.name
}

resource "aws_iam_policy" "kms_policy" {
  name        = "KMS${local.name}"
  description = "Policy EC2 With System Manager"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": {
        "Effect": "Allow",
        "Action": [
            "kms:DescribeKey",
            "kms:GenerateDataKey",
            "kms:Decrypt"
        ],
        "Resource": ["${var.kms_arn}"]
    }
}
EOF
}

resource "aws_iam_policy_attachment" "kms_policy_attachment" {
  name       = "KMSPolicyAttachtoRole${local.name}"
  roles      = [aws_iam_role.default.name]
  policy_arn = aws_iam_policy.kms_policy.arn
}
