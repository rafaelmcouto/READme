# AWS RDS Module

Este módulo tem por objetivo provisionar o recurso Lambda

# Utilização

```terraform
module "lambda" {
  source        = "git@gitlab.kenlo.io:infrastructure/terraform.git//providers/aws/lambda"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.app_subnets
  function_name = "my_lambda.py"
  method        = "executa"
  runtime       = "python3.7"
  tags_shared   = local.tags
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

* `function_name` - Nome exclusivo para sua função Lambda.

* `method` - O nome do método que executa a função que está no código.

* `runtime` - (Opcional) Identificador do tempo de execução da função. Consulte os tempos de execução para obter os valores válidos. [Runtimes](https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime)

* `vpc_id` - O ID da VPC onde o lambda será criado.

* `subnet_ids` - O ID da SubNet onde o Lambda será criado.

* `description` - (Opcional) Descrição do que sua função Lambda faz.

* `timeout` - (Opcional) Quantidade de tempo que sua função Lambda tem para ser executada em segundos. O padrão é 3. Consulte Limites.

* `ingress` - (Opcional) Se precisar de mais de um ingress.

* `lambda_vpc_policy` - (Opcional) Policy para criação de interface de rede.

* `lambda_logging_policy` - (Opcional) Policy para criação de grupo no CloudWatch.

# Outputs

* `arn` - Amazon Resource Name (ARN) identificando sua função Lambda.

* `invoke_arn` - ARN a ser usado para invocar a Função Lambda do API Gateway - a ser usado no uri de aws_api_gateway_integration.
