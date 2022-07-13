resource "null_resource" "run-on-eks-cluster-creation" {
    count    = var.eks_autosetup_on_create ? 1 : 0
    triggers = {
        cluster_id = aws_eks_cluster.eks-cluster.id
    }
    depends_on = [
        aws_eks_cluster.eks-cluster,
        aws_autoscaling_group.eks-worker-node-template-autoscaling-group,
        aws_iam_openid_connect_provider.eks_cluster_openid_provider,
        aws_iam_policy.aws-loadbalancer-controller-iam-policy,
        local_file.setup-eks
    ]
    provisioner "local-exec" {
        when = create
        working_dir = "temp"
        interpreter = ["/bin/bash", "-c"]
        command     = <<EOT
            ./setup-eks-${var.eks_cluster_identifier}.sh
        EOT
    }
}