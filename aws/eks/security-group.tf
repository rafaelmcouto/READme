############################################################################################
#                             Master Node Configuration                                    #
############################################################################################
resource "aws_security_group" "eks-cluster" {
  name        = "EKS ${var.eks_cluster_identifier} Cluster Master Nodes"
  description = "Cluster Communication with Worker Nodes"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags_shared,
    tomap({ "Name" = "EKS${var.eks_cluster_identifier}" })
  )
}

resource "aws_security_group_rule" "eks-cluster-ingress-workstation-https" {
  cidr_blocks       = var.eks_cluster_allowed_ingress_ips
  description       = "Allow Kubectl to Communicate with the Cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks-cluster.id
  to_port           = 443
  type              = "ingress"
}

############################################################################################
#                             Worker Node Configuration                                    #
############################################################################################
resource "aws_security_group" "eks-worker-node" {
  name        = "EKS${var.eks_cluster_identifier}WorkersNodes"
  description = "Security Group for All Nodes in the Cluster ${var.eks_cluster_identifier}"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags_shared,
    tomap({
      "Name"                                                = "${var.eks_cluster_identifier}-Workers-Nodes",
      "kubernetes.io/cluster/${var.eks_cluster_identifier}" = "shared"
    })
  )
}

resource "aws_security_group" "eks-worker-node-client" {
  name        = "EKS${var.eks_cluster_identifier}Client"
  description = "Allow Connections from Worker Node on AWS Resources"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags_shared,
    tomap({
      "Name" = "EKS${var.eks_cluster_identifier}Client"
    })
  )
}

resource "aws_security_group_rule" "eks-worker-node-ingress-self" {
  description              = "Allow Worker Node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks-worker-node.id
  source_security_group_id = aws_security_group.eks-worker-node.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks-worker-node-ingress-cluster" {
  description              = "Allow Worker Kubelets and pods to receive communication from the Cluster Control Plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-worker-node.id
  source_security_group_id = aws_security_group.eks-cluster.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks-worker-node-ingress-node-https" {
  description              = "Allow Pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-cluster.id
  source_security_group_id = aws_security_group.eks-worker-node.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks-cluster-ingress-node-https" {
  description              = "Allow Cluster API Server to communicate with the PODs"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-worker-node.id
  source_security_group_id = aws_security_group.eks-cluster.id
  to_port                  = 443
  type                     = "ingress"
}
