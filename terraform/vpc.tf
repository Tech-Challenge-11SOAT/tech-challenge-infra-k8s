module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = format("%s-vpc", var.aws_region)
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"] # INSERIR VARIÁVEL
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true

  tags = {
    FIAP = "TechChallenge"
  }

  private_subnet_tags = {
    "Name"                                  = format("%s-private-subnet", var.eks_name),
    "kubernetes.io/role/internal-elb"       = 1,
    "kubernetes.io/cluster/${var.eks_name}" = "shared"
  }

  public_subnet_tags = {
    "Name"                                  = format("%s-public-subnet", var.eks_name),
    "kubernetes.io/role/elb"                = 1,
    "kubernetes.io/cluster/${var.eks_name}" = "shared"
  }

}