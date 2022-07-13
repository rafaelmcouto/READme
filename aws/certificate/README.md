# AWS Certificate Module

Este módulo ter por objetivo provisionar o recurso Certificate Manager (ACM)

# Utilização

```terraform
module "certificate" {
  source    = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/certificate"
  certificate_name = "my-certificate"
  domain_name = "my-domain.com.br"
  subject_alternative_names = ["*.my-domain.com.br"]
  validation_method = "DNS"
}
```

# Argumentos

* `certificate_name` - nome do certificado que vai ser emitido

* `domain_name` - nome de domínio para o qual o certificado deve ser emitido

* `validation_method` - os métodos `DNS` ou `EMAIL` são válidos. `NONE` pode ser usado para certificados importados para o `ACM` e depois para o Terraform. O valor padrão é `DNS`

* `subject_alternative_names` - (Opcional) uma lista de domínios que devem ser `SANs` no certificado emitido. O valor padrão é `[]`

* `tags_shared` - (Opcional) mapa de string, chave-valor contendo as tags que serão associadas aos recursos criados

# Outputs

* `arn` - arn do certificado

* `domain_name` - nome do domínio para o qual o certificado é emitido

* `domain_validation_options` - nome do registro DNS a ser criado para validar o certificado

* `validation_emails` - lista de endereços que receberam um e-mail de validação

* `status` - status do certificado