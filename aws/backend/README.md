# AWS Backend Module

Este módulo tem por objetivo provisionar o recurso de Backend de inicialização da infraestrutura da AWS

# Utilização

```terraform
module "backend" {
  source = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/backend"
  bucket_name = "my-bucket"
  dynamodb_table_name = "my-table"
}
```

# Argumentos

* `bucket_name` - Nome do bucket s3, o nome deve ser exclusivo a nível global

* `dynamodb_table_name` - Nome da tabela do dynamodb, isso precisa ser exclusivo dentro de uma região AWS

* `acl` - (Opcional) Lista de controle de acesso do bucket. [Canned ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl). O valor padrão é "private"

* `block_public_acls` - (Opcional) A definição dessa opção como TRUE causa o seguinte comportamento:

    * As chamadas PUT bucket acl e PUT object falharão se a Access Control List (ACL – Lista de controle de acesso) especificada for pública.

    * As chamadas PUT object falharão se a solicitação incluir uma ACL pública.

    * Se essa configuração for aplicada a uma conta, as chamadas PUT bucket falharão se a solicitação incluir uma ACL pública.

    Quando essa configuração for definida como TRUE, as operações especificadas falharão (sejam feitas por meio da API REST, da AWS CLI ou dos SDKs da AWS). Porém, as políticas e as ACLs existentes para buckets e objetos não são modificadas. Essa configuração permite se proteger contra acesso público ao mesmo tempo em que permite auditar, refinar ou alterar as políticas e as ACLs existentes para os buckets e os objetos

* `block_public_policy` - (Opcional) Definir esta opção como TRUE para um bucket faz com que o Amazon S3 rejeite chamadas para a política PUC Bucket se a política de bucket especificada permitir acesso público e rejeite chamadas para a política PUT Access Point para todos os pontos de acesso do bucket se a política especificada permitir acesso público. Definir esta opção como TRUE para um ponto de acesso faz com que o Amazon S3 rejeite chamadas para a política PUT Access Point e a política PUT Bucket que são feitas por meio do ponto de acesso se a política especificada (para o ponto de acesso ou para o bucket subjacente) for pública. O valor padrão é true

* `ignore_public_acls` - (Opcional) A definição dessa opção como TRUE faz o Amazon S3 ignorar todas as ACLs públicas em um bucket e todos os objetos contidos. Essa configuração permite bloquear com segurança acesso público concedido por ACLs ao mesmo tempo em que permite chamadas PUT object que incluam uma ACL pública (ao contrário de BlockPublicAcls, que rejeita chamadas PUT object que incluam uma ACL pública). A habilitação dessa configuração não afeta a persistência de ACLs existentes nem evita a definição de novas ACLs públicas. O valor padrão é true

* `restrict_public_buckets` - (Opcional) A definição dessa opção como TRUE restringe o acesso a um ponto de acesso ou um bucket com uma política pública apenas a serviços da AWS e a usuários autorizados dentro da conta do proprietário do bucket. Essa definição bloqueia todo o acesso entre contas ao ponto de acesso ou ao bucket (exceto por serviços da AWS), ao mesmo tempo que continua permitindo que usuários dentro da conta gerenciem o ponto de acesso ou o bucket. O valor padrão é true.

* `tags_shared` - (Opcional) Mapa de string, chave-valor contendo as tags que serão associadas aos recursos criados

# Outputs

* `bucket_name` - Nome do Bucket S3

* `dynamodb_table_name` - Nome da tabela do DynamoDB