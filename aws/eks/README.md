# AWS EKS Module

Este módulo ter por objetivo provisionar o recurso EKS, possibilitando caso necessário a instalação do Cluster AutoScaler, HPA e Istio

# Utilização

```terraform
module "vpc" {
  source                     = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/vpc"
  vpc_name                   = "my-vpc"
  vpc_cidr_block             = "172.16.0.0/16"
  public_subnets_cidr_block  = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
  private_subnets_cidr_block = ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]
  // Add Tags for K8s auto-discover service
  is_eks_enabled             = true
  eks_name                   = var.eks_cluster_identifier
}

module "eks" {
  source                     = "git@gitlab.ingaia.com.br:devops/iac.git/terraform//providers/aws/eks"
  vpc_id                     = module.vpc.vpc_id
  private_subnets_ids        = module.vpc.private_subnets
  public_subnets_ids         = module.vpc.public_subnets
  eks_cluster_identifier     = var.eks_cluster_identifier
  aws_region                 = var.aws_region
}
```

# Argumentos

* `vpc_id` - id da vpc onde será construido o EKS.

* `private_subnets_ids` - lista de string contendo os ids das subnets privadas da vpc utilizada pelo EKS.

* `public_subnets_ids` - lista de string contendo os ids das subnets públics da vpc utilizada pelo EKS.

* `eks_cluster_identifier` - (Opcional) nome do cluster EKS. O valor padrão é `eks`.

* `eks_cluster_version` - (Opcional) versão do EKS. O valor padrão é `1.19`.

* `eks_cluster_allowed_ingress_ips` - (Opcional) Lista com asfaixa de Ips aos quais o EKS vai aceitar conexão. O valor padrão é `["0.0.0.0/0"]`.

* `eks_nodes` - (Opcional) Lista de Mapa de valores representando os workers group nodes, contendo os seguintes argumentos:

    * label - Label a ser adicionados ao Kubelet dos nodes, o qual pode ser usando no `nodeSelector`.

    * instanceType - Tipo da `EC2`.

    * minSize - número mínimo de instâncias que devem ser mantido nesse node group.

    * desiredSize - número desejado de nodes que o este node group deve ter.

    * maxSize - número desejado de nodes que o este node group deve ter.

    * instanceOndemandBaseSize - número base de instancias `(EC2) onDemand`, o qual deve sempre ser mantido.

    * instanceOnDemandPercentagem - Porcentagem de instâncias onDemand que deseja ser mantido neste node group, este valor não leva em consideração o número de máquinas definido na propriedade `instanceOndemandBaseSize`

    * enableAutoScale - Indica que se esse node group pode ser escalado. Só é possível escalar um node group.

    O valor padrão é : 
    ```
    [ 
        {
            "label" = "worker"
            "instanceType" = "m5.large"
            "minSize" = 1
            "desiredSize" = 1
            "maxSize" = 2
            "instanceOndemandBaseSize" = 1
            "instanceOnDemandPercentagem" = 100
            "enableAutoScale" = true
        }
    ]
    ``` 

* `eks_manager_user_arn` - (Opcional) identificador arn do usuário IAM (AWS) que terá acesso ao cluster EKS. O valor padrão é `null`.

* `eks_manager_user_name` - (Opcional) nome do usuário IAM (AWS) que terá acesso ao cluster EKS, essa variável deve representar o mesmo usuário indicado pela variável `eks_manager_user_arn`. O valor padrão é `null`.

* `eks_install_hpa` - (Opcional) Indica se o Horizontal Node AutoScaler (HPA) deve ser instalado. O valor padrão é `true`.

* `eks_hpa_namespace` - (Opcional) Namespace onde o HPA será instalado. O valor padrão é `metrics`.

* `eks_hpa_deployment_values_base64` - (Opcional) Valores utilizados para a instalação do HPA com Helm (values.yaml). O valor padrão é `null`.

* `eks_install_cluster_autoscaller` - (Opcional) Indica se o ClusterAutoScaler (CA) deve ser instalado. O valor padrão é `true`.

* `eks_cluster_autoscaler_namespace` - (Opcional) Namespace onde o CA será instalado. O valor padrão é `metrics`.

* `eks_cluster_autoscaler_deployment_values_base64` - (Opcional) Valores utilizados para a instalação do CA com Helm `(values.yaml)`. O valor padrão é `null`.

* `eks_worker_nodes_custom_permissions` - (Opcional) Policy IAM que será associada aos node groups denotado pela variável `eks_nodes`.

* `eks_install_istio` - (Opcional) Indica se o Istio (1.10.2) deve ser instalado. O valor padrão é `true`.

* `eks_istio_namespace` - (Opcional) Namespace onde o Istio será instalado. O valor padrão é `istio-system`.

* `aws_region` - região AWS onde o EKS será provisionado.

* `eks_install_prometheus` - (Opcional) Indica se o `Prometheus` deve ser instalado. O valor padrão é `true`.

* `eks_prometheus_pvc_storage` - (Opcional) Indica se o `Persistent Volume Claim` do `Prometheus Data` deve ser instalado. O valor padrão é `10Gi`.

* `eks_install_grafana` - (Opcional) Indica se o `Grafana` deve ser instalado. O valor padrão é `true`.

* `eks_install_kiali` - (Opcional) Indica se o `Kiali` deve ser instalado. O valor padrão é `true`.

* `eks_install_jaeger` - (Opcional) Indica se o `Jaeger` deve ser instalado. O valor padrão é `true`.

* `eks_install_aws_load_balancer_controller` - (Opcional) Indica se o `AWS Load Balancer Controller` deve ser instalado no Kubernetes. O valor padrão é `true`.

* `eks_repo_add_ons` - (Opcional) EKS ECR Repo para imagens AWS, muda para cada região, saiba mais ['Amazon EKS add-on container image addresses'](https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html). O valor padrão é `602401143452.dkr.ecr.us-east-1.amazonaws.com`.

* `eks_autosetup_on_create` - (Opcional) Se for `true`, ao criar o cluster já executa o script `./temp/setup-eks-${clusterName}.sh`. Após qualquer execução do script, não deve ser alterado de `false` para `true`, se o mesmo já tiver sido executado por essa opção, não será executado novamente. Essa opção só deve ser configurada ou alterada na criação do Cluster, alterações após isso poderá ocasionar problemas. O valor padrão é `false`.

* `tags_shared` - (Opcional) Mapa de String, chave-valor contendo as tags que serão associadas aos recursos criados

# Outputs

* `eks_arn` - arn do cluster EKS

* `eks_id` - id do cluster EKS

* `eks_client_security_group_id` - id do security group compartilhado do cluster EKS

# Outputs

Ao final da execução deste módulo o arquivo `temp/setup-eks.sh` é criado no diretório de execução, e este script deve ser executado pelo usuário que provisionou o EKS a fim de terminar a configuração do recurso, realizando os deploys necessários.

```
$ aws eks update-kubeconfig --name <nome do cluster> --profile <profile> --region <region>
$ ./temp/setup-eks-${clusterName}.sh
```
