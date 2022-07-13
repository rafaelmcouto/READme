# AWS ROLE Module

Este módulo ter por objetivo provisionar o recurso ROLE.

# Utilização

```terraform
module "role" {
  source  = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/role"
  name = "AllowEc2AcrossAWSAccounts"
  principals_type = "AWS"
  principals_identifiers = ["arn:aws:iam::447558891031:root"]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
```

# Argumentos

* `name` - Nome da Role

* `description` - (Opcional) Descrição da Role . O valor padrão é "-"

* `actions` - (Opcional) Lista de ações que são permitidas ou negadas. Os valores válidos são: `["sts:AssumeRole", "ec2:RunInstances", "s3:*"]`. O valor padrão é ["sts:AssumeRole"]

* `principals_type` - (Opcional) Especifica os tipos configuração do bloco principal. Os valores válidos são: `["AWS", "Service", "Federated", "CanonicalUser", "*"]`. O valor padrão é "Service"

* `principals_identifiers` - Lista de identificadores para a configuração do bloco principal. Exemplo de valor válido `["arn:aws:iam::447558891031:root"]`

* `policy` - Documento em formato JSON. Para obter mais informações sobre como criar políticas IAM com o Terraform, consulte o [AWS IAM Policy Document Guide](https://learn.hashicorp.com/terraform/aws/iam-policy?_ga=2.114661262.86319101.1627300323-1996858497.1624287519)

* `force_detach_policies` - (Opcional) Especifica a desconexão das políticas atachadas a `Role` antes de destruí-la. O valor padrão é true

* `tags_shared` - (Opcional) Mapa de string, chave-valor contendo as tags que serão associadas aos recursos criados

# Outputs

* `name` - nome da role

* `arn` - arn da role
