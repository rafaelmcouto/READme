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
  name        = "KMSToSSM${local.name}"
  description = "Policy to EC2 >> System Manager"

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

resource "aws_iam_policy" "ssm_policy" {
  name        = "SSMPolicy${local.name}"
  description = "Policy to EC2 >> System Manager"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeAssociation",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:GetDocument",
                "ssm:DescribeDocument",
                "ssm:GetManifest",
                "ssm:GetParameter",
                "ssm:GetParameters",
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:PutInventory",
                "ssm:PutComplianceItems",
                "ssm:PutConfigurePackageResult",
                "ssm:UpdateAssociationStatus",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateInstanceInformation"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:PassRole",
                "iam:ListInstanceProfiles",
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "kms_policy_attachment" {
  name       = "KMSPolicyAttachtoRole${local.name}"
  roles      = [aws_iam_role.default.name]
  policy_arn = aws_iam_policy.kms_policy.arn
}

resource "aws_iam_policy_attachment" "ssm_policy_attachment" {
  name       = "SSMPolicyAttachtoRole${local.name}"
  roles      = [aws_iam_role.default.name]
  policy_arn = aws_iam_policy.ssm_policy.arn
}
