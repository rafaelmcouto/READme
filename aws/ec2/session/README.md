# AWS EC2 Module

Este módulo ter por objetivo provisionar o recurso EC2, em uma subnet pública ou privada.

`Se conecta através do Systems Manager e não faz o uso de chaves SSH (.pem)`

# Utilização

```terraform
module "vpc" {
  source                     = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/vpc"
  vpc_name                   = "my-vpc"
  vpc_cidr_block             = "10.100.0.0/16"
  app_subnets_cidr_block     = ["10.100.0.0/20", "10.100.16.0/20", "10.100.32.0/20"]
  data_subnets_cidr_block    = ["10.100.96.0/24", "10.100.97.0/24", "10.100.98.0/24"]
  pub_subnets_cidr_block     = ["10.100.100.0/22", "10.100.104.0/22", "10.100.108.0/22"]
}
```

```terraform
module "kms" {
  source     = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/kms"
  key_alias  = "my-kms"
}
```

```terraform
module "ec2" {
  source      = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/ec2/session"
  name        = "my-instance"
  vpc_id      = module.vpc.vpc_id
  subnet_id   = element(module.vpc.pub_subnets, 0)
  kms_arn     = module.kms.arn
}
```

# Argumentos

* `name` - Nome da instância EC2.

* `ami` - AMI da instância EC2. O valor padrão é `ami-09e67e426f25ce0d7` do `Ubuntu 20.04`.

* `vpc_id` - ID da VPC.

* `subnet_id` - ID da Subnet `pública` ou `privada`.

* `iam_instance_profile` - IAM do Profile para iniciar a instância `EC2`. Permissões necessárias para usar `roles` nas instâncias `EC2` [documentação](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html#roles-usingrole-ec2instance-permissions).

* `kms_arn` - ARN do KMS criado que será usado na criptografia.

* `instance_type` - (Opcional) Tipo de instância. O valor padrão é `t3.small`.

* `volume_size` - (Opcional) Tamanho do volume em `gibibytes (GiB)`. O valor padrão é `10`.

* `volume_type` - (Opcional) Tipo de volume. Os valores permitidos são: `standard`, `gp2`, `gp3`, `io1`, `io2`, `sc1` ou `st1`. O valor padrão é `gp3`.

* `delete_on_termination` - (Opcional) Especifica se o `volume` deve ser excluído ao encerrar uma instância EC2. O valor padrão é `true`.

* `encrypted` - (Opcional) Especifica se o `volume` deve ser encriptado. O valor padrão é `true`.

* `is_enabled_public_ip` - (Opcional) Especifica se um `elastic ip` é associado a instância EC2. O valor padrão é `false`.

* `security_group_ingress` - (Opcional) Lista de configuração das regras de entrada dos `Security Groups` associados. 

O valor padrão é:

```terraform
[
    {
      description = null
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
```

* `cloudwatch_is_enabled_create_alarm` - (Opcional) Especifica se o `cloudwatch alarm` deverá ser criado. O valor padrão é `false`.

* `cloudwatch_threshold` - (Opcional) Especifica o valor ao qual a estatística especificada é comparada. O valor padrão é `70`.

* `cloudwatch_alarm_actions_sns_arn` - (Opcional) Lista de ações a serem executadas quando o alarme passar de um estado para outro estado. `Cada ação é especificada como um ARN de um SNS`. O valor padrão é `[]`.

* `tags_shared` - (Opcional) Mapa de String, chave-valor contendo as tags que serão associadas aos recursos criados.

# Outputs

* `arn` - ARN da instância EC2.

* `public_ip` - IP público atribuído à instância EC2.