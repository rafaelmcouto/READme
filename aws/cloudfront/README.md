# AWS Certificate Module

Este módulo ter por objetivo provisionar o recurso Cloudfront

# Utilização

```terraform
module "cloudfront" {
  source    = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/cloudfront"
  identifier = "my-cloudfront"
}
```

# Argumentos

* `identifier` - (Optional) nome do cloudfront. O valor padrão é `default`.

* `root_object` - (Optional) objeto que o CloudFront retorna quando um usuário solicita a `URL`. O valor padrão é `index.html`.

* `allowed_methods` - controla quais métodos `HTTP` processam e encaminham as requisições para o `CloudFront` e o bucket `S3` ou sua origem personalizada. O valor padrão é `["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]`.

* `cached_methods` - controla se o `CloudFront` armazena em `Cache` a resposta às solicitações usando os métodos `HTTP` especificados. O valor padrão é `["GET", "HEAD"]`.

* `price_class` - (Optional) classe de preço para esta distribuição. Os valores permitidos são: `PriceClass_All`, `PriceClass_100` e `PriceClass_200`. O valor padrão é `PriceClass_200`.

* `viewer_protocol_policy` - use este elemento para especificar o protocolo que os usuários podem usar para acessar os arquivos na origem especificada por `TargetOriginId` quando uma solicitação corresponde ao padrão de caminho em `PathPattern`. Os valores permitidos são: `allow-all`, `https-only` e `redirect-to-https`. O valor padrão é `redirect-to-https`.

* `min_ttl` - (Optional) a quantidade mínima de tempo em `segundos` que você deseja que os objetos permaneçam em `Caches` do `CloudFront` antes de consultar sua origem para ver se o objeto foi atualizado. O valor padrão é `0`.

* `max_ttl` - (Optional) a quantidade máxima de tempo em `segundos` que um objeto está em um `Cache` do `CloudFront` antes de encaminhar outra solicitação para sua origem para determinar se o objeto foi atualizado. Eficaz apenas na presença dos `Headers Cache-Control max-age`, `Cache-Control s-maxage` e `Expires`. O valor padrão é `86400`.

* `default_ttl` - (Optional) a quantidade padrão de tempo em `segundos` que um objeto está em um `Cache` do `CloudFront` antes de encaminhar outra solicitação na ausência de um `Headers Cache-Control max-age` e `Expires`. O valor padrão é `3600`.

* `error_code` - código de status `HTTP 4xx` ou `5xx` que você deseja personalizar. O valor padrão é `404`.

* `response_code` - (Opcional) código de status `HTTP` que você deseja que o `CloudFront` retorne com a página de erro personalizada para o visualizador. O valor padrão é `404`.

* `aliases` - (Optional) `CNAMEs` extras (nomes de domínio alternativos), se houver, para esta distribuição. O valor padrão é `[]`.

* `comment` - (Optional) um comentário da distribuição. O valor padrão é `-`.

* `acm_certificate_arn` - ARN do certificado ACM que você deseja usar com esta distribuição. Especifique isso, `cloudfront_default_certificate` ou `iam_certificate_id`. O certificado ACM deve estar em `US-EAST-1`. O valor padrão é `null`.

* `default_certificate` - certificado ACM `padrão` para usar o nome de domínio do `CloudFront` para sua distribuição. Com o valor `false` deverá ser especificado um `acm_certificate_arn` ou `iam_certificate_id`. O valor padrão é `true`.

* `tags_shared` - (Opcional) mapa de string, chave-valor contendo as tags que serão associadas aos recursos criados

# Outputs

* `id` - ID do Cloudfront

* `arn` - ARN do Cloudfront

* `domain_name` - Nome do domínio do Cloudfront

* `status` - Status do Cloudfront