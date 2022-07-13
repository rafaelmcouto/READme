resource "aws_iam_policy" "aws-loadbalancer-controller-iam-policy" {
  name   = "__Eks${var.eks_cluster_identifier}_AWSLoadBalancerControllerIAMPolicy"
  path   = "/"
  policy = data.aws_iam_policy_document.aws-load-balancer-controller-permissions.json
}

data "aws_iam_policy_document" "aws-load-balancer-controller-permissions" {
  statement {
    actions = [
      "iam:CreateServiceLinkedRole",
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeVpcs",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeInstances",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeTags",
      "ec2:GetCoipPoolUsage",
      "ec2:DescribeCoipPools",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeListenerCertificates",
      "elasticloadbalancing:DescribeSSLPolicies",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:DescribeTags",
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "cognito-idp:DescribeUserPoolClient",
      "acm:ListCertificates",
      "acm:DescribeCertificate",
      "iam:ListServerCertificates",
      "iam:GetServerCertificate",
      "waf-regional:GetWebACL",
      "waf-regional:GetWebACLForResource",
      "waf-regional:AssociateWebACL",
      "waf-regional:DisassociateWebACL",
      "wafv2:GetWebACL",
      "wafv2:GetWebACLForResource",
      "wafv2:AssociateWebACL",
      "wafv2:DisassociateWebACL",
      "shield:GetSubscriptionState",
      "shield:DescribeProtection",
      "shield:CreateProtection",
      "shield:DeleteProtection",
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress",
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "ec2:CreateSecurityGroup",
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "ec2:CreateTags",
    ]
    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"

      values = [
        "false"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "ec2:CreateAction"

      values = [
        "CreateSecurityGroup"
      ]
    }
    effect    = "Allow"
    resources = ["arn:aws:ec2:*:*:security-group/*"]
  }
  statement {
    actions = [
      "ec2:DeleteTags",
      "ec2:CreateTags",
    ]
    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"

      values = [
        "true"
      ]
    }
    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"

      values = ["false"]
    }
    effect    = "Allow"
    resources = ["arn:aws:ec2:*:*:security-group/*"]
  }
  statement {
    actions = [
      "ec2:RevokeSecurityGroupIngress",
      "ec2:DeleteSecurityGroup",
      "ec2:AuthorizeSecurityGroupIngress",
    ]
    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"

      values = [
        "false"
      ]
    }
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "elasticloadbalancing:CreateTargetGroup",
      "elasticloadbalancing:CreateLoadBalancer",
    ]
    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"

      values = [
        "false"
      ]
    }
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "elasticloadbalancing:DeleteRule",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:CreateRule",
      "elasticloadbalancing:CreateListener",
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "elasticloadbalancing:RemoveTags",
      "elasticloadbalancing:AddTags",
    ]
    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"

      values = [
        "true"
      ]
    }
    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"

      values = [
        "false"
      ]
    }
    effect    = "Allow"
    resources = [
      "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
      "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
      "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*",
    ]
  }
  statement {
    actions = [
      "elasticloadbalancing:RemoveTags",
      "elasticloadbalancing:AddTags",
    ]
    effect    = "Allow"
    resources = [
      "arn:aws:elasticloadbalancing:*:*:listener/net/*/*/*",
      "arn:aws:elasticloadbalancing:*:*:listener/app/*/*/*",
      "arn:aws:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
      "arn:aws:elasticloadbalancing:*:*:listener-rule/app/*/*/*",
    ]
  }
  statement {
    actions = [
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:SetIpAddressType",
      "elasticloadbalancing:SetSecurityGroups",
      "elasticloadbalancing:SetSubnets",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:DeleteTargetGroup",
    ]
    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"

      values = ["false"]
    }
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:DeregisterTargets",
    ]
    effect    = "Allow"
    resources = ["arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"]
  }
  statement {
    actions = [
      "elasticloadbalancing:SetWebAcl",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:AddListenerCertificates",
      "elasticloadbalancing:RemoveListenerCertificates",
      "elasticloadbalancing:ModifyRule",
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}
