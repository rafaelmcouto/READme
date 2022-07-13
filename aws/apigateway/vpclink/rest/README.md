# AWS API Gateway VPC Links Rest APIs Module

Este módulo ter por objetivo provisionar o recurso API Gateway VPC Links Rest APIs

# Utilização

```terraform
module "apigateway_vpclink" {
  source      = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/apigateway/mapping"
  name        = "my-vpc_link"
  description = "my-description"
  load_balancer_arn = "arn:aws:elasticloadbalancing:us-east-1:300599944307:loadbalancer/net/balancer/f1cytx5b0bfgtb060e"
}
```

# Argumentos

* `name` - Nome da VPC Link.

* `description` - (Opcional) Descrição da VPC Link. O valor padrão é `null`.

* `load_balancer_arn` - ARN do `Network Load Balancer` da VPC. `Atualmente a AWS suporta apenas 1 Load Balancer`.

# Outputs

* `id` - Identificador único do VPC Link
