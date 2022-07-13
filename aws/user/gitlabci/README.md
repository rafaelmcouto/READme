# AWS ROLE Module

Este módulo tem por objetivo provisionar o usuário gitlabci e a role gitlabci, além de configurar as policies necessárias para o mesmo.

# Utilização

```terraform
module "user_gitlabci" {
  source           = "git@gitlab.kenlo.io:infrastructure/terraform.git//providers/aws/user/gitlabci"
  ecr_repositories = [
    {
      region     = "us-east-1"
      account_id = "345403943107"
    }
  ]
  allow_lambda_role_lambda_full = true
  tags_shared      = local.tags
}
```

# Argumentos

* `username` - (Opcional) Nome do usuário a ser criado. Valor padrão `gitlabci`.

* `ecr_repositories` - (Opcional) Lista de ECR Repositories que o usuário gitlabci tem acesso com a account ID e região. Valor padrão `[{ region = "us-east-1"     account_id = "345403943107"}]`.

* `enable_eks` - (Opcional) Ativa ou desativa policies para deploy em eks no usuário `gitlabci`. Valor padrão é `true`.

* `enable_lambda` - (Opcional) Ativa ou desativa policies para deploy em lambda no usuário `gitlabci`. Valor padrão é `true`.

* `enable_lambda_sqs` - (Opcional) Ativa ou desativa policies para deploy em lambda com `sqs` no usuário `gitlabci`. Valor padrão é `true`.

* `enable_lambda_apigateway` - (Opcional) Ativa ou desativa policies para deploy em lambda com `API Gateway` no usuário `gitlabci`. Valor padrão é `true`.

* `enable_lambda_event_bridge` - (Opcional) Ativa ou desativa policies para deploy em lambda com `Event Bridge` no usuário `gitlabci`. Valor padrão é `true`.

* `allow_lambda_role_lambda_full` - (Opcional) Ativa ou desativa liberação da role `lambdaFull` como uma das roles liberadas para ser utilizada em lambdas. Valor padrão é `false`.

* `lambda_roles_arns` - (Opcional) Outras roles liberadas para ser utilizada em lambdas. Valor padrão é `[]`.

* `tags_shared` - (Opcional) Mapa de string, chave-valor contendo as tags que serão associadas aos recursos criados

# Outputs

* `role_arn` - arn da Role __gitlabci

* `user_arn` - arn do Usuário gitlabci

* `username` - nome do Usuário gitlabci

* `policy_describe_eks_clusters_same_account` - arn da Policy __describe_eks_clusters_same_account

* `policy_update_ecr_repository_system` - arn da Policy __update_ecr_repository_system

* `policy_deploy_lambda_function` - arn da Policy __deploy_lambda_function

* `policy_deploy_lambda_iam` - arn da Policy __deploy_lambda_iam

* `policy_deploy_lambda_sqs` - arn da Policy __deploy_lambda_sqs

* `policy_deploy_lambda_sns` - arn da Policy __deploy_lambda_sns

* `policy_deploy_lambda_apigateway` - arn da Policy __deploy_lambda_apigateway

* `policy_deploy_lambda_event_bridge` - arn da Policy __deploy_lambda_event_bridge

