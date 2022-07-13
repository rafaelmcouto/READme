# AWS API Gateway VPC Links Http APIs Module

Este módulo ter por objetivo provisionar o recurso API Gateway VPC Links Http APIs

# Utilização

```terraform
module "apigateway_vpclink" {
  source      = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/apigateway/mapping"
  name        = "my-vpc_link"
  security_group_ids = ["sg-00001b9004f18526ee"]
  subnets_ids        = ["subnet-09793ce1b125fa8uf", "subnet-010381536f03f9d8x", "subnet-013ce46t89c23d0b8"]
}
```

# Argumentos

* `name` - Nome da VPC Link.

* `security_group_ids` - Lista de IDs de Security Group para o VPC Link.

* `subnets_ids` - Lista de IDs de Subnets para o VPC Link`.

# Outputs

* `id` - Identificador único do VPC Link
