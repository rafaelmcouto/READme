locals {
  config_map_aws_auth                   = <<CONFIGMAPAWSAUTH
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.eks-worker-node.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes 
CONFIGMAPAWSAUTH
  config_map_aws_auth_with_user_manager = <<CONFIGMAPAWSAUTHMANAGER
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.eks-worker-node.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
  mapUsers: |
    - userarn: ${var.eks_manager_user_arn != null ? var.eks_manager_user_arn : ""}
      username: ${var.eks_manager_user_name != null ? var.eks_manager_user_name : ""}
      groups:
        - system:masters 
CONFIGMAPAWSAUTHMANAGER
  config_autoscaller                    = templatefile("${path.module}/values/autoscaler-values.tmpl", { AWS_REGION = var.aws_region, CLUSTER_NAME = var.eks_cluster_identifier })
  kubernetes_tags = tomap({
    "kubernetes.io/cluster/${var.eks_cluster_identifier}" = "owned"
  })
  kubernetes_autoscalling_tags = tomap({
    "k8s.io/cluster-autoscaler/${var.eks_cluster_identifier}" = "owned",
    "k8s.io/cluster-autoscaler/enabled"                       = "true"
  })
}

data "template_file" "shell-script" {
  template = file("${path.module}/scripts/setup.sh")
  vars = {
    CLUSTER_NAME = var.eks_cluster_identifier
    REGION       = var.aws_region
    AWS_AUTH     = base64encode(var.eks_manager_user_arn != null ? local.config_map_aws_auth_with_user_manager : local.config_map_aws_auth)
  }
}

data "template_file" "shell-hpa-script" {
  template = file("${path.module}/scripts/install_hpa.sh")
  vars = {
    INSTALL_HPA   = var.eks_install_hpa ? 1 : 0
    HPA_NAMESPACE = var.eks_hpa_namespace
    HPA_VALUES = var.eks_hpa_deployment_values_base64 != null ? (
      var.eks_hpa_deployment_values_base64) : (
      base64encode(templatefile("${path.module}/values/hpa-values.tmpl", {}))
    )
  }
}

data "template_file" "shell-ca-script" {
  template = file("${path.module}/scripts/install_cluster_autoscaler.sh")
  vars = {
    INSTALL_CA   = var.eks_install_cluster_autoscaller ? 1 : 0
    CA_NAMESPACE = var.eks_cluster_autoscaler_namespace
    CA_VALUES = var.eks_cluster_autoscaler_deployment_values_base64 != null ? (
      var.eks_cluster_autoscaler_deployment_values_base64) : (
      base64encode(templatefile("${path.module}/values/autoscaler-values.tmpl", { AWS_REGION = var.aws_region, CLUSTER_NAME = var.eks_cluster_identifier }))
    )
  }
}

data "template_file" "shell-aws-load-balancer-controller" {
  template = file("${path.module}/scripts/install_aws_load_balancer_controller.sh")
  vars = {
    INSTALL_AWS_LOAD_BALANCER_CONTROLLER    = var.eks_install_aws_load_balancer_controller || var.eks_install_istio ? 1 : 0
    CLUSTER_NAME                            = var.eks_cluster_identifier
    REGION                                  = var.aws_region
    ARN_AWS_LOAD_BALANCER_CONTROLLER_POLICY = aws_iam_policy.aws-loadbalancer-controller-iam-policy.arn
    EKS_REPO_ADD_ONS                        = var.eks_repo_add_ons
  }
}

data "template_file" "shell-istio-script" {
  template = file("${path.module}/scripts/install_istio.sh")
  vars = {
    INSTALL_ISTIO   = var.eks_install_istio ? 1 : 0
    CLUSTER_NAME    = var.eks_cluster_identifier
    ISTIO_NAMESPACE = var.eks_istio_namespace
    ISTIO_SUBNETS   = join(",", var.private_subnets_ids)
  }
}

data "template_file" "shell-prometheus-script" {
  template = file("${path.module}/scripts/install_prometheus.sh")
  vars = {
    INSTALL_PROMETHEUS   = var.eks_install_prometheus ? 1 : 0
    PROMETHEUS_NAMESPACE = var.eks_istio_namespace
    PROMETHEUS_VALUES    = base64encode(templatefile("${path.module}/values/istio/prometheus.tmpl", { PVC_STORAGE = var.eks_prometheus_pvc_storage }))
  }
}

data "template_file" "shell-grafana-script" {
  template = file("${path.module}/scripts/install_grafana.sh")
  vars = {
    INSTALL_GRAFANA   = var.eks_install_grafana ? 1 : 0
    GRAFANA_NAMESPACE = var.eks_istio_namespace
    GRAFANA_VALUES    = base64encode(templatefile("${path.module}/values/istio/grafana.tmpl", {}))
  }
}

data "template_file" "shell-kiali-script" {
  template = file("${path.module}/scripts/install_kiali.sh")
  vars = {
    INSTALL_KIALI   = var.eks_install_kiali ? 1 : 0
    KIALI_NAMESPACE = var.eks_istio_namespace
    KIALI_VALUES    = base64encode(templatefile("${path.module}/values/istio/kiali.tmpl", {}))
  }
}

data "template_file" "shell-jaeger-script" {
  template = file("${path.module}/scripts/install_jaeger.sh")
  vars = {
    INSTALL_JAEGER   = var.eks_install_jaeger ? 1 : 0
    JAEGER_NAMESPACE = var.eks_istio_namespace
    JAEGER_VALUES    = base64encode(templatefile("${path.module}/values/istio/jaeger.tmpl", {}))
  }
}

resource "local_file" "setup-eks" {
  content = join("\n", [
    data.template_file.shell-script.rendered,
    data.template_file.shell-hpa-script.rendered,
    data.template_file.shell-ca-script.rendered,
    data.template_file.shell-aws-load-balancer-controller.rendered,
    data.template_file.shell-istio-script.rendered,
    data.template_file.shell-prometheus-script.rendered,
    data.template_file.shell-grafana-script.rendered,
    data.template_file.shell-kiali-script.rendered,
    data.template_file.shell-jaeger-script.rendered
  ])
  filename        = "temp/setup-eks-${var.eks_cluster_identifier}.sh"
  file_permission = "0755"
}
