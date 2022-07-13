# AWS ALB Module

Este módulo ter por objetivo provisionar o recurso Application LoadBalancer (ALB)

# Utilização

```terraform
module "vpc" {
  source                     = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/vpc"
  vpc_name                   = "my-vpc"
  vpc_cidr_block             = "172.16.0.0/16"
  public_subnets_cidr_block  = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
  private_subnets_cidr_block = ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]
}

module "loadbalancer" {
  source      = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/loadbalancer/application"
  name        = "my-elb"
  subnets_ids = module.vpc.private_subnets

  access_logs = [{ 
      bucket  = "my-bucket",
      prefix  = "my-lb",
      enabled = false
  }]

  listeners = {
    http = {
      port            = "80",
      protocol        = "HTTP",
      ssl_policy      = null,
      certificate_arn = null,
      default_action = {
        type             = "redirect",
        target_group_arn = null,
        redirect = {
          port        = "443",
          protocol    = "HTTPS",
          status_code = "HTTP_301"
        }
      }
    }
  }  
}
```

# Argumentos

* `name` - (Opcional) nome do loadbalancer.

* `name_prefix` - (Opcional) prefixo de nome para o loadbalancer contendo até `5` caracteres, caso essa variável seja usada a variável `name` não podera ser usada em conjunto.

* `internal` - (Opcional) Boolean indicando se o loadbalancer é `interno` ou `externo`. O valor padrão é `false`.

* `security_groups_ids` - (Opcional) Lista de IDs dos SecurityGroups para ser associada ao loadbalancer.

* `subnets_ids` - Lista de IDs das subnets do loadbalancer.

* `access_logs` - (Opcional) Log de acessos. O objeto deve conter as seguintes informações:

  * `bucket` - Nome do S3 bucket que armazena os logs.

  * `prefix` - (Opcional) Prefix do S3 bucket que armazena os logs.

  * `enabled` - (Opcional) Booleano habilitar/desabilitar o `access_logs`. O valor padrão é `false`.

* `subnet_mapping` - (Opcional) Mapeamento das subnets. O objeto deve conter as seguintes informações:

  * `subnet_id` - Lista de IDs das subnets. No mínimo `duas (2) subnets` devem ser informadas 

  * `allocation_id` - (Opcional) ID do Elastic IP address.

  * `private_ipv4_address ` - (Opcional) Um endereço `IPV4` privado dentro da sub-rede.

* `listeners` - Lista contendo as configurações roteamento `("ouvintes")` do loadbalancer. A lista deve conter as seguintes informações:

  * `port` - Porta do listener. Não é válido para Gateway Load Balancers. 

  * `protocol` - Protocolo do loadbalancer. O valores permitidos são: `HTTP` e `HTTPS`.

  * `ssl_policy` - Nome da `SSL Policy` do listener. Para saber mais consulte a [documentação](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-security-policy-table.html). O valor deve ser informado quando utilizar `HTTPS`. O valor padrão é `ELBSecurityPolicy-2016-08`.

  * `certificate_arn` - (Opcional) ARN do certificado. O valor padrão é `null`.

  * `default_action` - Lista contendo as configurações de ações do listener. A lista deve conter as seguintes informações:

    * `type` - Tipo de roteamento. O valor permitido é `redirect`.

    * `target_group_arn` - (Opcional) ARN do `Target Group` para onde o tráfego será roteado. O valor padrão é `null`. 

    * `redirect` - Lista contendo as configurações de ações de redirect do listener. A lista deve conter as seguintes informações:

        * `port` - (Opcional) Porta do listener. O valor permitido é `1` à `65535`. 

        * `protocol` - (Opcional) Protocolo do listener. O valor permitido é `HTTP` ou `HTTPS`.  

        * `status_code` - Código de redirecionamento HTTP. O redirecionamento é permanente `(HTTP_301)` ou temporário `(HTTP_302)`.    

* `idle_timeout` - (Opcional) Número em segundo que uma conexão pode ficar ociosa. O valor padrão é `60`.

* `enable_deletion_protection` - (Opcional) Booleano indicando que a `exclusão` do loadbalancer será `desabilitada` por meio da API AWS. `Isso impedirá que o Terraform exclua o loadbalancer`. O valor padrão é `false`.

* `enable_cross_zone_load_balancing` - (Opcional) Booleano indicando se o loadbalancer deve ser provisionado em mais de uma zona. O valor padrão é `true`.

* `tags_shared` - (Opcional) Mapa de String, chave-valor contendo as tags que serão associadas aos recursos criados.

# Outputs

* `arn` - ARN do loadbalancer

* `name` - Nome do loadbalancer

* `dns_name` - Nome dns do loadbalancer
