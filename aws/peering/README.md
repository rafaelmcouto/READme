# AWS Peering Module

Este módulo ter por objetivo provisionar o recurso Peering.

# Utilização

```terraform
module "peering" {
  source                 = "git@gitlab.kenlo.io:infrastructure/terraform.git//providers/aws/peering"
  name_vpc_owner         = "requester_vpc_name"
  vpc_id                 = module.vpc.vpc_id
  destination_cidr_block = module.vpc.vpc_cidr_block
  route_table_id         = module.vpc.app_routing_table_id
  accepter_region        = "sa-east-1"
  name_vpc_accepter      = "accepter_vpc_name"
  vpc_id_accepter        = "vpc-xxx"
  subnet_id_accepter     = "subnet-xxx"
}
```

# Argumentos

* `peer_owner_id` - (Opcional) O ID da conta AWS do proprietário do par VPC. O padrão é a ID da conta à qual o provedor AWS está conectado no momento.

* `peer_vpc_id` - O ID do VPC com o qual você está criando a conexão de peering de VPC.

* `access_key` - Chave da conta que vai aceitar o peering.

* `secret_key` - Secret da conta que vai aceitar o peering.

* `vpc_id` - O ID do VPC do solicitante.

* `peer_region` - (Opcional) A região do VPC aceitante da conexão de peering de VPC. auto_accept deve ser falso e usar aws_vpc_peering_connection_accepter para gerenciar o lado do aceitante.

* `vpc_peering_connection_id` - O ID de conexão de peering de VPC a ser gerenciado.

* `auto_accept` - (Opcional) Aceite o peering (ambos os VPCs precisam estar na mesma conta AWS).

* `route_table_id` - O ID da tabela de roteamento.

* `destination_cidr_block` - (Opcional) O bloco CIDR de destino.

* `name_vpc_owner` - Nome da VPC na conta Owner para identificar o Peering.

* `name_vpc_accepter` - Nome da VPC na conta de Accepter para identificar o Peering.

* `accepter_region` - Nome da região da conta de Accepter. O default -e us-east-1

* `subnet_id_accepter` - ID da SubNet de onde se deseja fazer o Peering.

* `vpc_id_accepter` - ID da VPC da conta de Accepter.

##

* `tags_shared` - (Opcional) Mapa de String, chave-valor contendo as tags que serão associadas aos recursos criados

# Outputs

* `aws_route_(owner/accept)_id` - Identificador de rota calculado a partir do identificador da tabela de roteamento e destino da rota.

* `aws_vpc_peering_connection_id` - O ID da conexão de peering VPC.

* `aws_vpc_peering_connection_accept_status` - O status da solicitação de conexão de peering VPC.

* `aws_vpc_peering_connection_accepter_id` - O ID da conexão de peering VPC.

* `aws_vpc_peering_connection_accepter_vpc_id` - O ID do VPC do aceitante.

* `aws_vpc_peering_connection_accepter_peer_vpc_id` - O ID do VPC do solicitante.

* `aws_vpc_peering_connection_accepter_peer_owner_id` - O ID da conta AWS do proprietário do VPC do solicitante.
