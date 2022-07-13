# SCRIPT CHARTS KAFKA EKS Module

Este módulo tem por objetivo provisionar os recursos atrávés de Helm Charts e Manifestos Kubernetes para o KAFKA no EKS.

# Utilização

```terraform
module "msk" {
  source                                  = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/msk"
  vpc_id                                  = module.vpc.vpc_id
  private_subnets_ids                     = module.vpc.app_subnets
  msk_name                                = var.msk_name
  msk_server_properties_file_path         = templatefile(var.msk_server_properties_file_path, {})
  msk_allowed_security_group_ids          = [module.eks.eks_client_security_group_id]
  msk_broker_client_encryption_in_transit = "TLS_PLAINTEXT"
}

module "scripts_eks" {
  source           = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/scripts/kafka/eks/"
  eks_install_schema_registry           = true
  eks_schema_registry_bootstrap_servers = module.msk.bootstrap_brokers
  eks_install_kafka_connect             = true
  eks_kafka_connect_bootstrap_servers   = module.msk.bootstrap_brokers
}
```

# Argumentos

* `eks_cluster_name` - (Opcional) Nome do cluster EKS. O valor padrão é `logging`.

* `eks_region` - (Opcional) Região AWS onde o EKS foi provisionado. O valor padrão é `us-east-1`.

* `eks_profile` - (Opcional) Nome do `profile` com as credenciais da AWS `(~/.aws/credentials)`. O valor padrão é `sandbox`.

* `eks_kafka_namespace` - (Opcional) Namespace onde vai ser instaldos os deployments do `Kubernetes`. O valor padrão é `kafka`.

* `eks_install_schema_registry` - (Opcional) Indica se o `Schema Registry` deve ser instaldo. O valor padrão é `false`.

* `eks_schema_registry_node_selector` - (Opcional) Tag `Node Selector` que especifica em qual `Node do Kubernetes` os deployments vão ser instalados. O valor padrão é `data`.

* `eks_schema_registry_heap_options` - (Opcional) Especifica o valor da `JVM Heap Option`. O valor padrão é `-Xms512M -Xmx512M`.

* `eks_schema_registry_bootstrap_servers` - Especifica a lista de `Bootstrap Brokers` usados pela comunicação do cliente com o `cluster MSK`. O valor padrão é `null`.

* `eks_schema_registry_broker_client_encryption` - Especifica o protocolo usado pela comunicação do cliente com o `cluster MSK`. Os valores permitidos são: `TLS` e `PLAINTEXT`. O valor padrão é `PLAINTEXT`.

* `eks_install_kafka_connect` - (Opcional) Indica se o `Kafka Connect` deve ser instaldo. O valor padrão é `false`.

* `eks_kafka_connect_node_selector` - (Opcional) Tag `Node Selector` que especifica em qual `Node do Kubernetes` os deployments vão ser instalados. O valor padrão é `worker`.

* `eks_kafka_connect_heap_options` - (Opcional) Especifica o valor da `JVM Heap Option`. O valor padrão é `-Xms512M -Xmx4096M`.

* `eks_kafka_connect_bootstrap_servers` - Especifica a lista de `Bootstrap Brokers` usados pela comunicação do cliente com o `cluster MSK`. O valor padrão é `null`.

* `eks_kafka_connect_broker_client_encryption` - Especifica o protocolo usado pela comunicação do cliente com o `cluster MSK`. Os valores permitidos são: `TLS` e `PLAINTEXT`. O valor padrão é `PLAINTEXT`.

* `eks_install_ksql_server` - (Opcional) Indica se o `KSql Server` deve ser instaldo. O valor padrão é `false`.

* `eks_ksql_server_node_selector` - (Opcional) Tag `Node Selector` que especifica em qual `Node do Kubernetes` os deployments vão ser instalados. O valor padrão é `data`.

* `eks_ksql_server_heap_options` - (Opcional) Especifica o valor da `JVM Heap Option`. O valor padrão é `-Xms512M -Xmx512M`.

* `eks_ksql_server_bootstrap_servers` - Especifica a lista de `Bootstrap Brokers` usados pela comunicação do cliente com o `cluster MSK`. O valor padrão é `null`.

* `eks_ksql_server_broker_client_encryption` - Especifica o protocolo usado pela comunicação do cliente com o `cluster MSK`. Os valores permitidos são: `TLS` e `PLAINTEXT`. O valor padrão é `PLAINTEXT`.

* `destination_filename` - (Opcional) Nome do aquivo `shell` de destino. O valor padrão é `setup`.

* `destination_file_path` - (Opcional) Especifica o caminho de destino do novo arquivo `shell`. O valor padrão é `./eks`.

* `destination_file_permission` - (Opcional) Especifica a permissão do novo arquivo `shell`. O valor padrão é `0755`.

# Outputs

* `Nenhum atributo adicional é exportado`
