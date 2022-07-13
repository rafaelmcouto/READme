# AWS API Gateway Module

Este módulo ter por objetivo provisionar o recurso API Gateway

# Utilização

```terraform
module "apigateway" {
  source                  = "git@gitlab.kenlo.io:infrastructure/terraform.git//providers/aws/apigateway/swagger"
  name                   = "my-api"
  swagger_path           = base64encode(templatefile("../artifacts/swagger.yaml", {}))
  saved_deployments_path = "../artifacts/apigateway-saved-deployments.json"
  stages                 = {
     stg = { name = "staging", variables = { balancer = "xufgdf4c7c203c4xxx9e4d8039oo95411-1530025905.us-east-1.elb.amazonaws.com" } }
  }
}
```

# Argumentos

* `name` - nome da REST API. O valor padrão é `default`.

* `description` - (Opcional) descrição da REST API. O valor padrão é `-`.

* `swagger_path` - caminho do arquivo `YAML` de configuração do `Swagger`. O arquivo `YAML` deve ser exportado como `Swagger` + `API Gateway Extensions` em `Stages`. Deve ser aplicado a codificação `Base64` no arquivo `base64encode(templatefile("caminho do arquivo YAML", {}))`. Se não for informado um arquivo para ser importado o módulo vai importar um arquivo `modelo`. O valor padrão é `null`.

* `saved_deployments_path` - (Opcional) caminho do arquivo `JSON` em que os `sha1` dos deployments são salvos, se não definir esse caminho para o arquivo, a cada alteração da API Gateway não é mantido os deployments anteriores que poderia ser utilizado para voltar um deployment anterior. Esse arquivo deverá ser salvo junto com o repositório para manter os deployments da API Gateway. O valor padrão é `null`.

* `stages` - Lista de Mapa de valores representando as `variáveis` do `Stage`, contendo os seguintes argumentos:

    * name - Nome do Stage.

    * variables - Mapa de valores das variáveis.

    O valores permitidos: 
    ```
    {
      stg = { name = "staging", variables = { balancer = "xufgdf4c7c203c4xxx9e4d8039oo95411-1530025905.us-east-1.elb.amazonaws.com" } }
     }
    ``` 
    
O valor padrão é `{}`.

* `endpoint_type` - (Opcional) lista de tipos de endpoints. Este recurso atualmente suporta `um único valor`. Valores válidos: `EDGE`, `REGIONAL` ou `PRIVATE`. Se não for especificado, o padrão é `EDGE`. Deve ser declarado como `REGIONAL` em partições não comerciais. Consulte a [documentação](https://docs.aws.amazon.com/pt_br/apigateway/latest/developerguide/create-regional-api.html) para obter mais informações sobre a diferença entre APIs `edge-optimized` e `regional`.

* `tags_shared` - (Opcional) mapa de string, chave-valor contendo as tags que serão associadas aos recursos criados.

# Outputs

* `arn` - arn da REST API.
