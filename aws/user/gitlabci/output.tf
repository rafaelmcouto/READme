output "role_arn" {
  description = "Arn of Role __gitlabci"
  value       = aws_iam_role.gitlabci.arn
}

output "user_arn" {
  description = "Arn of User gitlabci"
  value       = aws_iam_user.gitlabci.arn
}
output "username" {
  description = "Name of User gitlabci"
  value       = aws_iam_user.gitlabci.name
}

# Policies
output "policy_describe_eks_clusters_same_account" {
  description = "Arn of Policy __describe_eks_clusters_same_account"
  value       = var.enable_eks ? aws_iam_policy.describe_eks_clusters_same_account[0].arn : null
}

output "policy_update_ecr_repository_system" {
  description = "Arn of Policy __update_ecr_repository_system"
  value       = var.enable_eks ? aws_iam_policy.update_ecr_repository_system[0].arn : null
}

output "policy_deploy_lambda_function" {
  description = "Arn of Policy __deploy_lambda_function"
  value       = var.enable_lambda ? aws_iam_policy.deploy_lambda_function[0].arn : null
}

output "policy_deploy_lambda_iam" {
  description = "Arn of Policy __deploy_lambda_iam"
  value       = var.enable_lambda && length(local.lambda_roles_arns_merged) > 0 ? aws_iam_policy.deploy_lambda_iam[0].arn : null
}

output "policy_deploy_lambda_sqs" {
  description = "Arn of Policy __deploy_lambda_sqs"
  value       = var.enable_lambda && var.enable_lambda_sqs ? aws_iam_policy.deploy_lambda_sqs[0].arn : null
}

output "policy_deploy_lambda_sns" {
  description = "Arn of Policy __deploy_lambda_sns"
  value       = var.enable_lambda && var.enable_lambda_sns ? aws_iam_policy.deploy_lambda_sns[0].arn : null
}

output "policy_deploy_lambda_apigateway" {
  description = "Arn of Policy __deploy_lambda_apigateway"
  value       = var.enable_lambda && var.enable_lambda_apigateway ? aws_iam_policy.deploy_lambda_apigateway[0].arn : null
}

output "policy_deploy_lambda_event_bridge" {
  description = "Arn of Policy __deploy_lambda_event_bridge"
  value       = var.enable_lambda && var.enable_lambda_event_bridge ? aws_iam_policy.deploy_lambda_event_bridge[0].arn : null
}