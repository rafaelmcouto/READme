locals {
  lambda_roles_arns_merged = concat(var.lambda_roles_arns, var.allow_lambda_role_lambda_full == true ? ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/lambdaFull"] : [])
}
