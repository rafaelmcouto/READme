# AWS Secrets Manager Module

Este módulo tem por objetivo provisionar o recurso Secrets Manager

# Utilização

```terraform
module "secrets_manager" {
  source = "../services/secrets_manager"
  tags_shared = merge(
    local.tags,
    tomap({
      "CreatedBy" = "User Name"
    })
  )
}
```

# Argumentos

* `name` - (Opcional) Especifica o nome amigável do novo segredo. O nome secreto pode consistir em letras maiúsculas, letras minúsculas, dígitos e qualquer um dos seguintes caracteres: /_+=.@- Conflitos com name_prefix.

* `description` - (Opcional) Uma descrição do segredo.

# Outputs

* `id` - Nome do recurso Amazon (ARN) do segredo.

* `arn` - Nome do recurso Amazon (ARN) do segredo.

* `secret_string` - (Opcional) Especifica os dados de texto que você deseja criptografar e armazenar nesta versão do segredo. Isso é necessário se secret_binary não estiver definido.
