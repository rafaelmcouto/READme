# AWS ECR Module

Este módulo ter por objetivo provisionar o recurso ECR e suas políticas de acesso.

# Utilização

```terraform

module "ecr" {
  source    = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/ecr"
  name      = "my-ecr"
}
```

# Argumentos

* `name` - Nome do repositório `ECR`.

* `create_policy` - (Opcional) booleano indicando se uma `política customizada` será associada ao repositório ECR. O valor padrão é `false`.

* `policy` - (Opcional) política customizada a ser associada ao repositório, e ela deve seguir a estrutura [IAM Policy documents da AWS](https://docs.aws.amazon.com/pt_br/IAM/latest/UserGuide/access_policies.html). O uso desta política dependa da ativação da variável `create_policy`. O valor padrão é `null`.

* `tags_shared` - (Opcional) Mapa de String, chave-valor contendo as tags que serão associadas aos recursos criados

# Outputs

* `url` - Url do repositório ECR.