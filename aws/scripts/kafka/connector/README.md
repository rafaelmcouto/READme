# SCRIPT KAFKA CONNECTOR/SINK Module

Este módulo tem por objetivo provisionar os recursos de Kafka Connector e Sink.

# Utilização

```terraform
module "connector" {
  source           = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/scripts/kafka/connector/"
  source_file_path = "./artifacts/kafka/kafka-connector.sh"
}
```

# Argumentos

* `source_file_path` - Especifica o caminho do template do arquivo `shell`. 

* `destination_filename` - (Opcional) Nome do aquivo `shell` de destino. O valor padrão é `connector`.

* `destination_file_path` - (Opcional) Especifica o caminho de destino do novo arquivo `shell`. O valor padrão é `./connectors`.

* `destination_file_permission` - (Opcional) Especifica a permissão do novo arquivo `shell`. O valor padrão é `0755`.

# Outputs

* `Nenhum atributo adicional é exportado`
