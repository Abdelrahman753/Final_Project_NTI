  resource "aws_eks_cluster" "eks_cluster" {
    name     = var.eks_cluster_name
    role_arn = aws_iam_role.eks_cluster_role.arn
    version  = var.eks_cluster_version
    

    vpc_config {
      subnet_ids = var.subnet_ids
      
      endpoint_private_access = true
      endpoint_public_access  = true

    }

    depends_on = [
      aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy,
      aws_iam_role_policy_attachment.eks_cluster_AmazonEKSServicePolicy,
    ]

    tags = {
      Environment = var.env
    }
  }

  resource "aws_iam_role" "eks_cluster_role" {
    name = var.eks_cluster_name

    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Principal = {
            Service = "eks.amazonaws.com"
          }
          Action = "sts:AssumeRole"
        }
      ]
    })
  }

  resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role       = aws_iam_role.eks_cluster_role.name
  }

  resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSServicePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
    role       = aws_iam_role.eks_cluster_role.name
  }

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.eks_cluster_name}-node-group"
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = var.subnet_ids

  instance_types = var.instance_types
  ami_type       = "AL2023_x86_64_STANDARD"

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_capacity
    min_size     = var.min_capacity
  }


  labels = { env = var.env }
  tags   = merge(var.tags, { Name = "${var.eks_cluster_name}-node-group" })

  depends_on = [
    aws_iam_role_policy_attachment.node_group_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_group_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_group_AmazonEC2ContainerRegistryReadOnly,
  ]
}
  resource "aws_iam_role" "node_group_role" {
    name = "${var.eks_cluster_name}-node-group-role"

    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Principal = {
            Service = "ec2.amazonaws.com"
          }
          Action = "sts:AssumeRole"
        }
      ]
    })
  }

  resource "aws_iam_role_policy_attachment" "node_group_AmazonEKSWorkerNodePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.node_group_role.name
  }

  resource "aws_iam_role_policy_attachment" "node_group_AmazonEKS_CNI_Policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.node_group_role.name
  }

  resource "aws_iam_role_policy_attachment" "node_group_AmazonEC2ContainerRegistryReadOnly" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.node_group_role.name
  }


  data "tls_certificate" "eks" {
    url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
  }

  resource "aws_iam_openid_connect_provider" "eks" {
    url             = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
    client_id_list  = ["sts.amazonaws.com"]
    thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]

    tags = var.tags
  }

  resource "aws_iam_policy" "aws_load_balancer_controller" {
    name        = "${var.env}-AWSLoadBalancerControllerIAMPolicy"
    description = "IAM policy for AWS Load Balancer Controller"
    policy      = file("${path.module}/iam_policy.json")
  }

  locals {
    oidc_issuer = replace(aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://", "")
  }

  resource "aws_iam_role" "aws_load_balancer_controller" {
    name = "${var.env}-aws-load-balancer-controller-irsa"

    assume_role_policy = jsonencode({
      Version = "2012-10-17",
      Statement = [{
        Effect = "Allow",
        Principal = {
          Federated = aws_iam_openid_connect_provider.eks.arn
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "${local.oidc_issuer}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller",
            "${local.oidc_issuer}:aud" = "sts.amazonaws.com"
          }
        }
      }]
    })

    tags = var.tags
  }

  resource "aws_iam_role_policy_attachment" "alb_controller_attach" {
    role       = aws_iam_role.aws_load_balancer_controller.name
    policy_arn = aws_iam_policy.aws_load_balancer_controller.arn
  }





# =========================
# IRSA for EBS CSI Driver
# ServiceAccount: kube-system/ebs-csi-controller-sa
# =========================
resource "aws_iam_role" "ebs_csi_driver" {
  name = "${var.env}-ebs-csi-driver-irsa"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Federated = aws_iam_openid_connect_provider.eks.arn
      },
      Action = "sts:AssumeRoleWithWebIdentity",
      Condition = {
        StringEquals = {
          "${local.oidc_issuer}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa",
          "${local.oidc_issuer}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver_attach" {
  role       = aws_iam_role.ebs_csi_driver.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}


resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name             = aws_eks_cluster.eks_cluster.name
  addon_name               = "aws-ebs-csi-driver"
  service_account_role_arn = aws_iam_role.ebs_csi_driver.arn

  resolve_conflicts_on_update = "OVERWRITE"

  depends_on = [
    aws_iam_openid_connect_provider.eks,
    aws_iam_role_policy_attachment.ebs_csi_driver_attach
  ]
}