# AWS API Gateway Domain Module

Este módulo ter por objetivo provisionar o recurso API Gateway Domain

# Utilização

```terraform
module "certificate" {
  source           = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/certificate"
  certificate_name = "my-certificate"
  domain_name      = "my-domain.com.br"
}
```

```terraform
module "apigateway_domain" {
  source          = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/apigateway/domain"
  domain_name     = "my-apidomain.com.br"
  certificate_arn = module.certificate.arn
}
```

# Argumentos

* `domain_name` - nome do Domínio.

* `certificate_arn` - (Opcional) ARN para um certificado gerenciado pela AWS. O `AWS Certificate Manager é a única fonte compatível`. Quando se quer usar o `edge-optimized domain`. O valor padrão é `null`.

* `regional_certificate_arn` - (Opcional) ARN para um certificado gerenciado pela AWS. O `AWS Certificate Manager é a única fonte compatível`. Quando se quer usar o `regional domain`. O valor padrão é `null`.

* `security_policy` - (Opcional) A versão do `Transport Layer Security (TLS)` + `cipher suite` para este `DomainName`. Valores válidos: `TLS_1_0` ou `TLS_1_2`. O valor padrão é `TLS_1_2`.

* `endpoint_type` - (Opcional) lista de tipos de endpoints. Este recurso atualmente suporta `um único valor`. Valores válidos: `EDGE` ou `REGIONAL`. Se não for especificado, o padrão é `EDGE`. Deve ser declarado como `REGIONAL` em partições não comerciais. Consulte a [documentação](https://docs.aws.amazon.com/pt_br/apigateway/latest/developerguide/create-regional-api.html) para obter mais informações sobre a diferença entre APIs `edge-optimized` e `regional`.

* `tags_shared` - (Opcional) mapa de string, chave-valor contendo as tags que serão associadas aos recursos criados.

# Outputs

* `domain_name` - nome do domínio da API Gateway Domain.
