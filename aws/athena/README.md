# AWS ATHENA Module

Este módulo ter por objetivo provisionar o recurso Athena Workgroup.

# Utilização

```terraform
module "athena" {
  source     = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/athena"
  name  = "default"
}
```

# Argumentos

* `name` - Nome do workgroup

* `description` - (Opcional) Descrição do workgroup conforme visualizada no console da AWS. O valor padrão é ""

* `state` - (Opcional) Especifica se a estado está ativo. Os valores válidos são: `DISABLED` ou `ENABLED`. O valor padrão é ENABLED

* `force_destroy` - (Opcional) Especifica a opção de excluir o grupo de trabalho e seu conteúdo, mesmo se o grupo de trabalho contiver quaisquer consultas nomeadas. O valor padrão é false

* `configuration` - Configurações para o grupo de trabalho. O objeto deve conter as seguintes variáveis:

  * `enforce_workgroup_configuration` - Configuração do grupo de trabalho que substitue as configurações do lado do cliente. O valor padrão é true

  * `publish_cloudwatch_metrics_enabled` - Configuração das métricas do Amazon CloudWatch para o grupo de trabalho. O valor padrão é true

* `output_location` - (Opcional) Nome do Amazon S3 onde os resultados da sua consulta são armazenados.

* `encryption_configuration` - (Opcional) Configurações de criptografia. O objeto deve conter as seguintes variáveis:

  * `encryption_option` - Configuração da criptografia do lado do servidor Amazon S3 com chaves gerenciadas pelo Amazon S3 (`SSE_S3`), criptografia do lado do servidor com chaves gerenciadas por KMS (`SSE_KMS`) ou criptografia do lado do cliente com chaves gerenciadas e usada pelo KMS (`CSE_KMS`). Se uma consulta for executada em um grupo de trabalho e o grupo de trabalho vai substituir as configurações do lado do cliente, a configuração do grupo de trabalho para criptografia será usada. Ele especifica se os resultados da consulta devem ser criptografados, para todas as consultas executadas neste grupo de trabalho. O valor padrão é SSE_KMS

  * `kms_key_arn ` - (Opcional) ARN da chave do KMS Key Amazon.

* `tags_shared` - (Opcional) Mapa de String, chave-valor contendo as tags que serão associadas aos recursos criados

# Outputs

* `arn` - arn da chave

* `id` - identificador globalmente exclusivo da chave
