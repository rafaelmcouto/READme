variable "vpc_id" { type = string }
variable "private_subnets_ids" { type = list(string) }
variable "public_subnets_ids" { type = list(string) }
variable "aws_region" { type = string }
variable "eks_cluster_identifier" {
  default = "eks"
  validation {
    condition     = can(regex("^[0-9A-Za-z-]+$", var.eks_cluster_identifier))
    error_message = "For the eks_cluster_identifier value only a-z, A-Z, 0-9 and hyphen (-) are allowed."
  }
}
variable "eks_cluster_version" { default = "1.19" }
variable "eks_cluster_allowed_ingress_ips" { default = ["0.0.0.0/0"] }
variable "eks_security_groups_ids" { default = [] }
variable "eks_nodes" { default = [
  {
    "label"                       = "worker"
    "instanceType"                = "m5.large"
    "minSize"                     = 1
    "desiredSize"                 = 1
    "maxSize"                     = 2
    "instanceOndemandBaseSize"    = 1
    "instanceOnDemandPercentagem" = 100
    "enableAutoScale"             = true
  }
] }
variable "eks_manager_user_arn" { default = null }
variable "eks_manager_user_name" { default = null }

variable "eks_worker_node_device_name" { default = "/dev/xvda" }
variable "eks_worker_node_device_ebs_encrypted" { default = true }
variable "eks_worker_node_device_ebs_volume_size" { default = 20 }
variable "eks_worker_node_device_ebs_volume_type" { default = "gp3" }

variable "eks_install_hpa" { default = true }
variable "eks_hpa_namespace" { default = "metrics" }
variable "eks_hpa_deployment_values_base64" { default = null }
variable "eks_install_cluster_autoscaller" { default = true }
variable "eks_cluster_autoscaler_namespace" { default = "metrics" }
variable "eks_cluster_autoscaler_deployment_values_base64" { default = null }
variable "eks_install_istio" { default = true }
variable "eks_istio_namespace" { default = "istio-system" }
variable "eks_istio_deployment_values_base64" { default = null }

variable "tags_shared" { type = map(any) }

variable "eks_worker_nodes_custom_permissions" {
  default = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "sns:*",
                "sqs:*",
                "s3:*",
                "sms:*",
                "lambda:InvokeFunction",
                "lambda:InvokeAsync",
                "cloudwatch:GetMetricData"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF
}
variable "eks_install_aws_load_balancer_controller" { default = true }
variable "eks_repo_add_ons" { default = "602401143452.dkr.ecr.us-east-1.amazonaws.com" }
variable "eks_install_prometheus" { default = true }
variable "eks_prometheus_pvc_storage" { default = 10 }
variable "eks_install_grafana" { default = true }
variable "eks_install_kiali" { default = true }
variable "eks_install_jaeger" { default = true }
variable "eks_autosetup_on_create" { default = false }
