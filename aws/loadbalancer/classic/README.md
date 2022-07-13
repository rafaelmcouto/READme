# AWS ELB Module

Este módulo ter por objetivo provisionar o recurso Classic LoadBalancer (ELB)

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
  source          = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/loadbalancer/classic"
  name = "my-elb"
  subnets_ids = module.vpc.private_subnets
  listeners = [{ 
    instance_port = 80,
    instance_protocol = "HTTP", 
    lb_port = 80, 
    lb_protocol = "HTTP", 
    ssl_certificate_id = "" 
  }]
  health_check = [{ 
    healthy_threshold = 2, 
    unhealthy_threshold = 2, 
    target = "TCP:80", 
    interval = 30, 
    timeout = 3 
  }]
}
```

# Argumentos

* `name` - (Opcional) nome do loadbalancer.

* `name_prefix` - (Opcional) prefixo de nome para o loadbalancer contendo até `5` caracteres, caso essa variável seja usada a variável `name` não podera ser usada em conjunto.

* `security_groups_ids` - (Opcional) Lista de IDs dos SecurityGroups para ser associada ao loadbalancer.

* `subnets_ids` - Lista de IDs das subnets do loadbalancer.

* `instances_ids` - (Opcional) Lista de `IDs` de EC2 que receberão tráfego do loadbalancer.

* `internal` - (Opcional) Boolean indicando se o loadbalancer é `interno` ou `externo`. O valor padrão é `false`.

* `listeners` - Lista contendo as configurações roteamento `("ouvintes")` do loadbalancer. A lista deve conter as seguintes informações:

  * `instance_port` - Porta do listener

  * `instance_protocol` - Protocolo do listener

  * `lb_port` - Porta do loadbalancer

  * `lb_protocol` - Protocolo do loadbalancer

  * `ssl_certificate_id` - (Opcional) ARN do certificado, caso não existe utilize o valor vazio `("")`

* `health_check` - (Opcional) Rota utilizada para verificar se os listeners estão ativos. O objeto deve conter as seguintes informações:

  * `healthy_threshold` - Número de tentativas antes que um listener seja considerado ativo.

  * `unhealthy_threshold` - Número de tentativas antes que um listener seja considerado desativo.

  * `target` - Destino da tentativa, sendo que está deverá seguir o modelo `${PROTOCOLO}:${PORTA}${CAMINHO}`

  * `interval` - Intervalo entre as tentativas

  * `timeout` - Tempo em segundos para que a tentiva expire

* `cross_zone_load_balancing` - (Opcional) Booleano indicando se o loadbalance deve ser provisionado em mais de uma zona. O valor padrão é `true`

* `idle_timeout` - (Opcional) Número em segundo que uma conexão pode ficar ociosa. O valor padrão é `60`.

* `connection_draining` - (Opcional) Booleano indicando se o loadbalancer irá realizar o `draining` de conexões. O valor padrão é `false`.

* `connection_draining_timeout` - (Opcional) Número em segundo que um `listener` ficará em processo de `draining`. O valor padrão é `300`.

* `tags_shared` - (Opcional) Mapa de String, chave-valor contendo as tags que serão associadas aos recursos criados.

# Outputs

* `arn` - ARN do loadbalancer

* `name` - Nome do loadbalancer

* `dns_name` - Nome dns do loadbalancer
