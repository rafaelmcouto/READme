# AWS KMS Module

Este módulo ter por objetivo provisionar o recurso KMS.

# Utilização

```terraform
module "kms" {
  source     = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/kms"
  key_alias  = "custom"
}
```

# Argumentos

* `description` - (Opcional) Descrição da chave conforme visualizada no console da AWS. O valor padrão é "-"

* `key_usage` - (Opcional) Identificador (Chave) pretendido. Os valores válidos são: `ENCRYPT_DECRYPT` e `SIGN_VERIFY`. O valor padrão é ENCRYPT_DECRYPT

* `customer_master_key_spec` - (Opcional) Identificador (Chave) que contém uma chave simétrica ou um par de chaves assimétricas e os algoritmos de criptografia ou algoritmos de assinatura que a chave suporta. Os valores válidos são: `SYMMETRIC_DEFAULT`, `RSA_2048`, `RSA_3072`, `RSA_4096`, `ECC_NIST_P256`, `ECC_NIST_P384`, `ECC_NIST_P521` e `ECC_SECG_P256K1`. O valor padrão é SYMMETRIC_DEFAULT

* `policy` - (Opcional) política AWS para o tópico sns, ela deve seguir a estrutura [IAM Policy documents da AWS](https://docs.aws.amazon.com/pt_br/IAM/latest/UserGuide/access_policies.html). Esta variável substitui a politica padrão oferecida por este módulo`. O valor padrão é null e a política é formada pelo seguinte trecho de códico

``` terraform
    data "aws_caller_identity" "current" {}

    data "aws_iam_policy_document" "administrators-permissions" {
        statement {
            sid = "Enable IAM Administrators Permissions"
            effect = "Allow"
            principals {
                type        = "AWS"
                identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
            }
            actions = ["kms:*"]
            resources = ["*"]
        }
    }
```
* `deletion_window_in_days` - (Opcional) Duração em dias após os quais a chave é excluída após a destruição do recurso, deve ser entre 7 e 30 dias. O valor padrão é 30

* `is_enabled` - Especifica se a chave está habilitada. O valor padrão é true

* `enable_key_rotation` - (Opcional) Rotação da chave habilitada. O padrão é false

* `tags_shared` - (Opcional) Mapa de String, chave-valor contendo as tags que serão associadas aos recursos criados

# Outputs

* `arn` - arn da chave

* `key_id` - identificador globalmente exclusivo da chave

* `alias_arn` - arn do alias

* `alias_name` - name do alias


