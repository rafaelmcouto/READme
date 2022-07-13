# SCRIPT KAFKA CONNECT Module

Este módulo tem por objetivo provisionar o recursos de Kafka Connect.

# Utilização

```terraform
module "ecr" {
  source      = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/ecr"
  name        = "kafka/kafka-connect"
}

module "connect" {
  source       = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/scripts/kafka/connect/"
  registry_url = module.ecr.url
}
```

# Argumentos

* `dockerfile_image` - (Opcional) Nome da imagem base do `Dockerfile`. O valor padrão é `confluentinc/cp-kafka-connect:6.1.0`.

* `dockerfile_runners` - (Opcional) Especifica uma lista de processos que serão executados em containers isolados e que rodam localmente na imagem base do `Dockerfile`. 

    O valor padrão é : 
    ```
    [ 
      "RUN confluent-hub install --no-prompt debezium/debezium-connector-sqlserver:1.4.0",
      "RUN confluent-hub install --no-prompt debezium/debezium-connector-mysql:1.6.0",
      "RUN confluent-hub install --no-prompt confluentinc/kafka-connect-s3:10.0.0",
      "RUN confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.1.0",
      "RUN confluent-hub install --no-prompt mongodb/kafka-connect-mongodb:1.5.0",
      "RUN confluent-hub install --no-prompt confluentinc/kafka-connect-s3-source:1.4.4",
      "RUN confluent-hub install --no-prompt confluentinc/kafka-connect-replicator:5.3.1",
      "RUN confluent-hub install --no-prompt confluentinc/kafka-connect-elasticsearch:11.0.6"
    ]
    ``` 

* `dockerfile_destination_filename` - (Opcional) Nome do aquivo `shell` de destino do `Dockerfile`. O valor padrão é `Dockerfile`.

* `registry_destination_filename` - (Opcional) Nome do aquivo `shell` de destino do `Build`. O valor padrão é `build`.

* `registry_url` - Url do AWS ECR.

* `registry_region` - (Opcional) Região AWS onde o EKS foi provisionado. O valor padrão é `us-east-1`.

* `registry_image_name` - (Opcional) Nome da imagem `Docker`. O valor padrão é `kafka-connect`.

* `registry_image_tag` - (Opcional) TAG da imagem `Docker`. O valor padrão é `latest`.

* `destination_file_path` - (Opcional) Especifica o caminho de destino do novo arquivo `shell`. O valor padrão é `./build`.

* `destination_file_permission` - (Opcional) Especifica a permissão do novo arquivo `shell`. O valor padrão é `0755`.

# Outputs

* `Nenhum atributo adicional é exportado`
