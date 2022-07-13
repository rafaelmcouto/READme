# AWS GLUE Module

Este módulo ter por objetivo provisionar o recurso Glue.

# Utilização

```terraform
module "glue" {
  source     = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/glue"
  databases  = { 
    db1 = { name = "mydatabase1", description = "-" },
    db2 = { name = "mydatabase2", description = "-" }
  }

  role_crawlers = { 
    role1 = { name = "myrole1", description = "-", bucket = "mybucketroleoutput1" },
    role1 = { name = "myrole2", description = "-", bucket = "mybucketroleoutput2" }
  }

  crawlers = { 
    crawler1 = { name = "mycrawler1", description = "-", role = "myrole1", bucket = "mybucketroleoutput1" },
    crawler2 = { name = "mycrawler2", description = "-", role = "myrole2", bucket = "mybucketroleoutput2" }
  }
}
```

# Argumentos

* `databases` - Lista de mapa de valores representando as `Databases`, contendo os seguintes argumentos:

    * name - Nome do database

    * description - Descrição do database
    
  O valor padrão é : 
  ```
  databases  = { 
    db = { name = "mydatabase", description = "-" }
  }
  ``` 
* `add_crawler` - (Opcional) Especifica se os `Crowlers` serão criados. O valor padrão é true e os mapas de valores `role_crawlers` e `crawlers` serão requeridos.

* `prefix_role` - (Opcional) Prefixo da `Role do Crawler` conforme visualizada no console da AWS. O valor padrão é "AWSGlueServiceRole"

* `force_detach_policies` - (Opcional) Especifica a desconexão das políticas atachadas na `Role` antes de destruí-la. O valor padrão é false

* `managed_policy_arns` - (Opcional) Lista de ARNs de políticas exclusivas para anexar à `Role` de IAM. O valor padrão é ["arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"]

* `role_crawlers` - Lista de mapa de valores representando as `Roles`, contendo os seguintes argumentos:

    * name - Nome da role

    * description - Descrição da role

    * bucket - Nome do bucket de output

  O valor padrão é : 
  ```
  role_crawlers = { 
    role = { name = "myrole", description = "-", bucket = "mybucketoutput" }
  }
  ``` 
* `crawlers` - Lista de mapa de valores representando os `Crawlers`, contendo os seguintes argumentos:

    * name - Nome do crawler

    * description - Descrição do crawler

    * role - Nome da role especificada na lista de `role_crawlers`

    * bucket - Nome do bucket de output especificado na lista de `role_crawlers`

  O valor padrão é : 
  ```
  crawlers  = { 
    crawler = { name = "mycrawler", description = "-", role = "myrole", bucket = "mybucketoutput" }
  }
  ``` 
* `tags_shared` - (Opcional) Mapa de String, chave-valor contendo as tags que serão associadas aos recursos criados

# Outputs

* `databases_arns` - lista de arn dos databases

* `databases_ids` - lista de identificador globalmente exclusivo da chave dos databases

* `crawlers_arns` - lista de arn dos crawlers

* `crawlers_ids` - lista de identificador globalmente exclusivo da chave dos crawlers
