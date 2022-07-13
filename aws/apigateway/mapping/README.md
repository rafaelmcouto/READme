# AWS API Gateway Mapping Module

Este módulo ter por objetivo provisionar o recurso API Gateway Mapping

# Utilização

```terraform
module "apigateway_mapping" {
  source      = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/apigateway/mapping"
  api_id      = module.apigateway.id
  stage_name  = lookup(module.apigateway.stage_name, "stg", "staging")
  domain_name = module.apigateway_domain.domain_name
}
```

# Argumentos

* `api_id` - ID da REST API.

* `stage_name` - (Opcional) nome de um estágio específico para expor o caminho. `Se omitido, as requisições podem selecionar qualquer estágio, incluindo o nome da API`. O valor padrão é `null`.

* `domain_name` - O nome de domínio registrado na `API`. 

* `base_path` - (Opcional) segmento que deve ser anexado ao caminho ao acessar a API por meio deste mapeamento. Se omitido, a API é exposta na raiz do domínio fornecido. `Mais de um estágio o segmento do estágio deve ser diferente, senão um erro será emitido`. O valor padrão é `null`.

# Outputs

* `Nenhum atributo adicional é exportado`
