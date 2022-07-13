# AWS MSK Module

Este módulo ter por objetivo provisionar o recurso MSK (Kafka) no Cluster da AWS. Definir configurações otimizadas do Kafka, monitoramento, logs no S3 e um projeto de segurança mínima.

## Utilização
---

```bash
module "vpc" {
  source                     = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/vpc"
  vpc_name                   = "my-vpc"
  vpc_cidr_block             = "172.16.0.0/16"
  public_subnets_cidr_block  = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
  private_subnets_cidr_block = ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]
}

module "msk" {
  source                     = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/eks"
  msk_name                   = "my-msk"
  vpc_id                     = module.vpc.vpc_id
  private_subnets_ids        = module.vpc.private_subnets
}
```

## Argumentos
---
Os seguintes argumentos são suportados:

* `msk_name` - Nome do Cluster MSK.

* `msk_version` - (Optional) Versão do Kafka a ser instalada no Cluster MSK. O valor padrão é `["2.8.0"]`.

* `msk_number_of_brokers` - (Optional) Número de Brokers no Cluster MSK. O valor padrão é `3`.

* `msk_broker_instance_size` - (Optional) Tipo de instâncias do Broker. O valor padrão é `kafka.t3.small`.

* `msk_broker_ebs_size` - (Optional) Tamano do disco (EBS) em GB, atachado em cada Bkoker. O valor padrão é `10`.

* `msk_broker_client_encryption_in_transit` - (Optional) Protocolo usado pela comunicação do cliente com o cluster MSK. Os valores permitidos são: `TLS`, `TLS_PLAINTEXT` e `PLAINTEXT`. O valor padrão é `TLS`.

* `msk_broker_in_cluster_encryption_in_transit` - (Optional) Força SSL na comunicação entre os Brokers. O valor padrão é `true`.

* `msk_allowed_output_ips` - (Optional) Lista com as faixas de IPs aos quais o MSK vai aceitar conexão através do Security Group. O valor padrão é `[0.0.0.0/0]`.

* `msk_allowed_security_group_ids` - (Optional) Lista com os IDs dos Security Group aos quais vão se comunicar com o Cluster MSK. O valor padrão é `[]`.

* `msk_server_properties_file_path` - (Optional) Caminho do arquivo de configuração do servidor Kafka. O valor padrão é `null`, ao qual é representado pelo [kafka.properties](./values/kafka.properties).

* `msk_storage_autoscalling_config` - (Optional) Mapa de valores que representam a configuração do Autoscaling do Storage de Logs. O valor padrão é `null` disabilita o Autoscaling do Storage. Os seguintes argumentos são suportados:

  * `msk_broker_maximum_ebs_size` - O tamanho máximo em GB que o EBS atachado a cada Broker pode atingir. O valor padrão é `100`.

  * `autoscalling_percentage_target` - Porcentagem que representa a quantidade de disco usado pelo Broker que irá acionar o storage autoscalling. O valor padrão é `75`
   
* `vpc_id` - Id da VPC onde será construido o Cluster MSK

* `private_subnets_ids` - Lista de string contendo os IDs das Subnets Privadas da VPC utilizada pelo MSK Broker. O Cluster MSK aceita `1` ou no máximo `3` Subnets.

* `tags_shared` - (Opcional) Mapa de string, chave-valor contendo as Tags que serão associadas aos recursos criados

## Outputs
---

* `arn` - ARN Cluster MSK (Amazon Resource Name).

* `zookeeper_connect_string` - Uma lista separada por vírgulas de um ou mais hostname:port a serem usados ​​para se conectar ao Cluster do Apache Zookeeper

* `bootstrap_brokers` - Uma lista separada por vírgulas de um ou mais hostname:port de Kafka Brokers adequados para Boostrap de conectividade com o Cluster kafka. Somente terá valores se `msk_broker_client_encryption_in_transit` estiver definido como `PLAINTEXT` ou `TLS_PLAINTEXT`.

* `bootstrap_brokers_tls` - Uma lista separada por vírgulas de um ou mais nomes de DNS (ou IPs) e pares de portas TLS para Kafka Brokers adequados para aumentar a conectividade com o Cluster kafka. Somente terá valores se `msk_broker_client_encryption_in_transit` estiver definido como `TLS_PLAINTEXT` ou `TLS`.

* `msk_client_security_group_id` - Id do Security Group que permite comunicação com o Cluster MSK.