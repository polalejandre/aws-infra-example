module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "= 20.14.0"

  cluster_name    = "example-${local.env}"
  cluster_version = "1.30"

  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true

  enable_kms_key_rotation = false
  kms_key_description     = "KMS key for example EKS cluster"

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns = {
      addon_version = var.cluster_addons_versions.coredns
    }
    kube-proxy = {
      addon_version = var.cluster_addons_versions.kube-proxy
    }
    vpc-cni = {
      addon_version  = var.cluster_addons_versions.vpc-cni
      before_compute = true
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  cluster_additional_security_group_ids = [
    aws_security_group.eks.id
  ]

  eks_managed_node_groups = {
    eks-main = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = var.instance_types[local.env]
      capacity_type  = var.capacity_type[local.env]
    }
  }
}

module "cluster_autoscaler" {
  source = "git::https://github.com/DNXLabs/terraform-aws-eks-cluster-autoscaler.git"

  enabled = true

  cluster_name                     = module.eks.cluster_id
  cluster_identity_oidc_issuer     = module.eks.cluster_oidc_issuer_url
  cluster_identity_oidc_issuer_arn = module.eks.oidc_provider_arn
  aws_region                       = local.region
}

resource "aws_security_group" "eks" {
  name        = "eks"
  vpc_id      = module.vpc.vpc_id
  description = "Security group for EKS"

  # VPC
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  # Bastion
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = -1
    security_groups = [aws_security_group.bastion.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  tags = {
    Name = "eks"
  }
}