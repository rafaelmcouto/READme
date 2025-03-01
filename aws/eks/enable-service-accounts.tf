data "tls_certificate" "eks_cluster_certificate" {
  url = aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_cluster_openid_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_cluster_certificate.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer
}