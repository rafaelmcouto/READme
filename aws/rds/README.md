# AWS RDS Module

Este módulo tem por objetivo provisionar o recurso RDS

# Utilização

```terraform
module "rds" {
  source           = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/rds"
  password         = "dasdhaIJILSDJAIdjla"
  data_subnets_ids = module.vpc.data_subnets
  vpc_id           = module.vpc.vpc_id
  tags_shared      = local.tags
}
```

Se tiver que adicionar mais entradas no Ingress, seguir o exemplo abaixo:
```
  ingress = [{
      description     = "Description do primeiro Ingress"
      from_port       = 5432 ( porta do DB )
      to_port         = 5432 ( porta do DB )
      protocol        = "tcp"
      security_groups = [module.eks.eks_client_security_group_id]
    }]
```

# Argumentos

* `data_subnets_ids` - Subnets de Dados onde o RDS será criado

* `allocated_storage` - O armazenamento alocado em gibibytes. Se max_allocated_storage estiver configurado, este argumento representa a alocação de armazenamento inicial e as diferenças da configuração serão ignoradas automaticamente quando ocorrer o escalonamento automático de armazenamento. Se replicate_source_db for definido, o valor será ignorado durante a criação da instância. OBS.: `A menos que um snapshot_identifier ou replicate_source_db seja fornecido`

* `apply_immediately` - (Opcional) Especifica se quaisquer modificações do banco de dados serão aplicadas imediatamente ou durante a próxima janela de manutenção. O padrão é false.

* `auto_minor_version_upgrade` - (Opcional) Indica que pequenas atualizações do motor serão aplicadas automaticamente à instância do banco de dados durante a janela de manutenção. O padrão é verdadeiro.

* `backup_retention_period` - (Optional) The days to retain backups for. Must be between 0 and 35. Must be greater than 0 if the database is used as a source for a Read Replica.

* `db_subnet_group_name` - (Opcional) Nome do grupo de sub-rede do banco de dados. A instância de banco de dados será criada no VPC associado ao grupo de sub-rede de banco de dados. Se não for especificado, será criado no VPC padrão ou no EC2 Classic, se disponível. Ao trabalhar com réplicas de leitura, ele deve ser especificado apenas se o banco de dados de origem especificar uma instância em outra região da AWS. Consulte DBSubnetGroupName na ação da API CreateDBInstanceReadReplica para restrições adicionais de réplica de leitura.

* `delete_automated_backups` - (Opcional) Especifica se os backups automatizados devem ser removidos imediatamente após a exclusão da instância de banco de dados. O padrão é verdadeiro.

* `engine` - O mecanismo de banco de dados a ser usado. Para obter os valores suportados, consulte o parâmetro Engine na ação da API CreateDBInstance. Observe que, para instâncias do Amazon Aurora, o mecanismo deve corresponder ao mecanismo do cluster de banco de dados '. Para obter informações sobre a diferença entre os mecanismos Aurora MySQL disponíveis, consulte Comparação entre Aurora MySQL 1 e Aurora MySQL 2 no Guia do usuário do Amazon RDS. OBS.: `A menos que um snapshot_identifier ou replicate_source_db seja fornecido`

* `engine_version` - (Opcional) A versão do mecanismo a ser usada. Se auto_minor_version_upgrade estiver habilitado, você pode fornecer um prefixo da versão como 5.7 (para 5.7.10) e este atributo irá ignorar diferenças na versão do patch automaticamente (por exemplo, 5.7.17). Para obter os valores suportados, consulte o parâmetro EngineVersion na ação da API CreateDBInstance. Observe que, para instâncias do Amazon Aurora, a versão do mecanismo deve corresponder à versão do mecanismo do cluster de banco de dados '. O valor padrão é 13.2

* `identifier` - (Opcional, força o novo recurso) O nome da instância RDS; se omitido, o Terraform atribuirá um identificador único aleatório. Obrigatório se restore_to_point_in_time for especificado.

* `instance_class` - O tipo de instância da instância RDS. O valor padrão é db.t3.micro.

* `maintenance_window` - (Opcional) A janela para realizar a manutenção em. Sintaxe: "ddd: hh24: mi-ddd: hh24: mi". Por exemplo: "Seg: 00: 00-Seg: 03: 00". Consulte os documentos da janela de manutenção do RDS para obter mais informações.

* `max_allocated_storage` - (Opcional) Quando configurado, o limite superior para o qual o Amazon RDS pode dimensionar automaticamente o armazenamento da instância de banco de dados. Configurar isso irá ignorar automaticamente as diferenças para alocado_storage. Deve ser maior ou igual a alocado_storage ou 0 para desativar o escalonamento automático de armazenamento.

* `name` - (Opcional) O nome do banco de dados a ser criado quando a instância de banco de dados for criada. Se este parâmetro não for especificado, nenhum banco de dados será criado na instância de banco de dados. Observe que isso não se aplica a mecanismos Oracle ou SQL Server. Consulte a documentação da AWS para obter mais detalhes sobre o que se aplica a esses mecanismos. Se você estiver fornecendo um nome de banco de dados Oracle, ele precisa estar em letras maiúsculas.

* `password` - Senha para o usuário mestre do banco de dados. Observe que isso pode aparecer nos logs e será armazenado no arquivo de estado. OBS.: `A menos que um snapshot_identifier ou replicate_source_db seja fornecido`

* `publicly_accessible` - (Opcional) Bool para controlar se a instância está acessível publicamente. O padrão é false.

* `skip_final_snapshot` - (Opcional) Determina se um instantâneo final do banco de dados é criado antes que a instância do banco de dados seja excluída. Se true for especificado, nenhum DBSnapshot será criado. Se false for especificado, um instantâneo do banco de dados será criado antes que a instância do banco de dados seja excluída, usando o valor de final_snapshot_identifier. O padrão é false.

* `storage_encrypted` - (Opcional) Especifica se a instância de banco de dados está criptografada. Observe que se você estiver criando uma réplica de leitura entre regiões, este campo será ignorado e, em vez disso, você deverá declarar kms_key_id com um ARN válido. O padrão é false se não for especificado.

* `storage_type` - (Opcional) Um de "padrão" (magnético), "gp2" (SSD de uso geral) ou "io1" (SSD IOPS provisionado). O padrão é "io1" se iops for especificado, "gp2" se não for.

* `tags_shared` - (Opcional) Mapa de String, chave-valor contendo as tags que serão associadas aos recursos criados

* `username` - Nome de usuário para o usuário mestre do banco de dados. OBS.: `A menos que um snapshot_identifier ou replicate_source_db seja fornecido`

# Outputs

* `arn` - arn do bando de dados

* `endpoint` - nome da instância do banco de dados

* `id` - nome da instância do banco de dados

* `name` - nome do banco de dados

* `username` - usuário master
