# AWS Directory Service Module

Este módulo ter por objetivo provisionar o recurso AWS Directory Service.

# Utilização

```terraform
module "directoryservice" {
  source = "../directoryservice"
  ds_name = "Nome_do_DirectoryService"
  vpc_id    = module.vpc.vpc_id
  subnet_ids = module.vpc.app_subnets
}
```

# Argumentos

* `ds_name` - O nome totalmente qualificado do diretório, como corp.example.com

* `password` - A senha do administrador de diretório ou usuário do conector.

* `vpc_id` - O identificador do VPC em que o diretório está.

* `subnet_ids` - Os identificadores das sub-redes para os servidores de diretório (2 sub-redes em 2 AZs diferentes).

* `description` - Uma descrição textual do diretório.

* `edition` - (Opcional) A edição MicrosoftAD (Standard ou Enterprise). O padrão é Enterprise (aplica-se apenas ao tipo MicrosoftAD).

* `type` - (Opcional) - O tipo de diretório (SimpleAD, ADConnector ou MicrosoftAD são valores aceitos). O padrão é SimpleAD.

# Outputs

* `access_url` - O URL de acesso para o diretório, como http://alias.awsapps.com.

* `dns_ip_addresses` - Uma lista de endereços IP dos servidores DNS para o diretório ou conector.

* `security_group_id` - O ID do grupo de segurança criado pelo diretório.

* `connect_ips` - Os endereços IP dos servidores AD Connector.

