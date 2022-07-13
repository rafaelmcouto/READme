# AWS Elasticache Redis Module

Este módulo ter por objetivo provisionar o recurso AWS Elasticache Redis

# Utilização

```terraform
module "redis" {
  source               = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/elasticache/redis"
  subnet_ids           = module.vpc.data_subnets
  vpc_id               = module.vpc.vpc_id
  tags_shared          = local.tags

  ingress = [{
      description     = "Description do primeiro Ingress"
      from_port       = 6379 ( porta do Redis )
      to_port         = 6379 ( porta do Redis )
      protocol        = "tcp"
      security_groups = [module.eks.eks_client_security_group_id]
    }]

}
```

# Argumentos

* `apply_immediately`- (Opcional) Especifica se quaisquer modificações serão aplicadas imediatamente ou durante a próxima janela de manutenção. O padrão é falso.

* `at_rest_encryption_enabled` - (Opcional) Se deve ativar a criptografia em repouso. 

* `automatic_failover_enabled` - (Opcional) Especifica se uma réplica somente leitura será automaticamente promovida a primária de leitura / gravação se a primária existente falhar. Se ativado, number_cache_clusters deve ser maior que 1. Deve ser ativado para grupos de replicação Redis (modo de cluster ativado). O padrão é falso.

* `availability_zones` - (Opcional) Uma lista de zonas de disponibilidade EC2 nas quais os clusters de cache do grupo de replicação serão criados. A ordem das zonas de disponibilidade na lista não é importante.

* `ingress` - Security Group de quem pode acessar o cluster.

* `maintenance_window` - (Opcional) Especifica o intervalo de tempo semanal para quando a manutenção no cluster de cache é executada. O formato é ddd: hh24: mi-ddd: hh24: mi (Relógio 24H UTC). A janela de manutenção mínima é de 60 minutos. Exemplo: sol: 05: 00-sol: 09: 00

* `node_type` - (Opcional) A classe de instância a ser usada. Consulte a documentação da AWS para obter informações sobre os tipos de nós suportados e orientações sobre como selecionar os tipos de nós. Obrigatório, a menos que global_replication_group_id seja definido. Não pode ser definido se global_replication_group_id estiver definido. 

* `number_cache_clusters` - (Opcional) O número de clusters de cache (primários e réplicas) que este grupo de replicação terá. Se Multi-AZ estiver habilitado, o valor deste parâmetro deve ser pelo menos 2. As atualizações ocorrerão antes de outras modificações. Um de number_cache_clusters ou cluster_mode é necessário. 

* `parameter_group_name` - (Opcional) O nome do grupo de parâmetro a ser associado a este grupo de replicação. Se este argumento for omitido, o grupo de parâmetro de cache padrão para o mecanismo especificado será usado. Para habilitar o "modo de cluster", ou seja, fragmentação de dados, use um grupo de parâmetros que tenha o parâmetro habilitado para cluster definido como verdadeiro.

* `port` - (Opcional) O número da porta na qual cada um dos nós de cache aceitará conexões. Para Memcache, o padrão é 11211 e para Redis, a porta padrão é 6379.

* `replication_group_description` - Uma descrição criada pelo usuário para o grupo de replicação.

* `replication_group_id` - O identificador do grupo de replicação. Este parâmetro é armazenado como uma string minúscula.

* `subnet_group_name` - (Opcional) O nome do grupo de sub-rede do cache a ser usado para o grupo de replicação.

* `subnet_ids` - Subnets para adicionar no Security Group.

* `transit_encryption_enabled` - (Opcional) Se deve ativar a criptografia em trânsito.

* `vpc_id` - Id da VPC onde o cluster será criado.

# Outputs

* `arn` - O Amazon Resource Name (ARN) do grupo de replicação ElastiCache criado.

* `configuration_endpoint_address` - O endereço do ponto de extremidade de configuração do grupo de replicação quando o modo de cluster está ativado.

* `primary_endpoint_address` - O endereço do terminal para o nó primário no grupo de replicação, se o modo de cluster estiver desabilitado.

* `reader_endpoint_address` - O endereço do ponto de extremidade para o nó do leitor no grupo de replicação, se o modo de cluster estiver desativado.
