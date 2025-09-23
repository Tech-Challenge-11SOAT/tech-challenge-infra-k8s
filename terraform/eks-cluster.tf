module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.1.5"

  name                    = var.eks_name
  kubernetes_version      = "1.33"
  subnet_ids              = module.vpc.private_subnets
  vpc_id                  = module.vpc.vpc_id
  endpoint_private_access = true
  endpoint_public_access  = true

  enable_cluster_creator_admin_permissions = true

  enable_irsa = true

  addons = {
  vpc-cni = {
    most_recent    = true
    before_compute = true
  }
  coredns    = { most_recent = true }
  kube-proxy = { most_recent = true }
  
  aws-ebs-csi-driver = {
    most_recent              = true
    service_account_role_arn = module.ebs_csi_irsa.iam_role_arn
  }

}


  eks_managed_node_groups = { 
    eks_nodes = {
      min_size     = 2
      max_size     = 5
      desired_size = 2

      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]
    }

  }
}

module "ebs_csi_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.34.0"

  role_name = "AmazonEKS_EBS_CSI_DriverRole"

  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn = module.eks.oidc_provider_arn
      namespace_service_accounts = [
        "kube-system:ebs-csi-controller-sa"
      ]
    }
  }
}
