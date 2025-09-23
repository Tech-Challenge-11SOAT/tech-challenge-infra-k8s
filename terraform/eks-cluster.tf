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


  addons = {
  vpc-cni = {
    most_recent    = true
    before_compute = true
  }
  
  coredns    = { most_recent = true }
  kube-proxy = { most_recent = true }

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