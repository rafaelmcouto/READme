# AWS VPC Module

Este módulo ter por objetivo provisionar o recurso VPC, provisionando subnets públicas já mapeadas para um ingress gateway e subnets privadas mapeadas para um NAT gateway.

# Utilização

```terraform
module "vpc" {
  source                     = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/vpc"
  vpc_name                   = "my-vpc"
  vpc_cidr_block             = "10.100.0.0/16"
  app_subnets_cidr_block     = ["10.100.0.0/20", "10.100.16.0/20", "10.100.32.0/20", "10.100.48.0/20", "10.100.64.0/20", "10.100.80.0/20"]
  data_subnets_cidr_block    = ["10.100.96.0/24", "10.100.97.0/24", "10.100.98.0/24"]
  pub_subnets_cidr_block     = ["10.100.100.0/22", "10.100.104.0/22", "10.100.108.0/22"]
}
```

# Argumentos

* `vpc_name` - (Opcional) nome da VPC. O valor padrão é "default"

* `vpc_cidr_block` - (Opcional) máscara de sub-rede a ser utilizada pela vpc. O valor padrão é "10.100.0.0/16"

* `app_subnets_cidr_block` - (Opcional) lista de string com as máscaras de ip das subnets privadas, a quantidade de elementos do array deve coindicir com o valor da variável `app_subnets`. O valor padrão é ["10.100.0.0/20", "10.100.16.0/20", "10.100.32.0/20", "10.100.48.0/20", "10.100.64.0/20", "10.100.80.0/20"]

* `data_subnets_cidr_block` - (Opcional) lista de string com as máscaras de ip das subnets privadas, a quantidade de elementos do array deve coindicir com o valor da variável `data_subnets`. O valor padrão é ["10.100.96.0/24", "10.100.97.0/24", "10.100.98.0/24"]

* `pub_subnets_cidr_block` - (Opcional) lista de string com as máscaras de ip das subnets públicas, a quantidade de elementos do array deve coindicir com o valor da variável `pub_subnets`. O valor padrão é ["10.100.100.0/22", "10.100.104.0/22", "10.100.108.0/22"]

* `app_subnets` - (Opcional) número de subnets privadas a serem criadas. O valor padrão é 3

* `data_subnets` - (Opcional) número de subnets privadas a serem criadas. O valor padrão é 3

* `pub_subnets` - (Opcional) número de subnets públicas a serem criadas. O valor padrão é 6

* `all_allowed_output_ips` - (Opcional) faixa de ip permitida nas rotas de entrada e saída das subnets públicas e privadas. O valor padrão é "0.0.0.0/0"

* `is_eks_enabled` - (Opcional) booleando indicando se um EKS será colocado na VPC, se sim as tags `kubernetes.io/cluster/<eks_name> : shared` serão adicionadas as subnets públicas e privadas. O valor padrão é false

* `eks_name` - (Opcional) nome do eks que será adicionado à VPC, sendo que esse valor é utilizado para compor a tag `kubernetes.io/cluster/<eks_name> : shared` e sua utilização depende da ativação da variável `is_eks_enabled`. O valor padrão é null

* `tags_shared` - (Opcional) Mapa de String, chave-valor contendo as tags que serão associadas aos recursos criados

# Outputs

* `vpc_id` - id da vpc

* `vpc_cidr_block` - máscara de sub-rede a ser utilizada pela vpc

* `app_subnets` - lista de string contendo os ids das subnets privadas da vpc

* `app_subnets_cidr_block` - lista das máscaras de ip utilizadas pelas subnets privadas

* `app_routing_table_id` - id da tabela de rotas das subnets privadas

* `app_subnets_availability_zone` - lista de availability zones das subnets privadas

* `data_subnets` - lista de string contendo os ids das subnets privadas da vpc

* `data_subnets_cidr_block` - lista das máscaras de ip utilizadas pelas subnets privadas

* `data_routing_table_id` - id da tabela de rotas das subnets privadas

* `data_subnets_availability_zone` - lista de availability zones das subnets privadas

* `pub_subnets` - lista de string contendo os ids das subnets públicas da vpc

* `pub_subnets_cidr_block` - lista das máscaras de ip utilizadas pelas subnets públicas

* `pub_routing_table_id` - id da tabela de rotas das subnets públicas

* `pub_subnets_availability_zone` - lista de availability zones das subnets públicas

* `vpc_default_security_group` - id da security group padrão da vpc

* `vpc_internet_gateway` - id do internet gateway da vpc
