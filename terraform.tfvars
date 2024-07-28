vpc_cidr = {
  dev = {
    eu-central-1 = "10.10.0.0/16"
    eu-west-1    = "10.11.0.0/16"
  }
  prod = {
    eu-central-1 = "10.20.0.0/16"
    eu-west-1    = "10.21.0.0/16"
  }
}

availability_zones = {
  "eu-central-1" = [
    "euc1-az1",
    "euc1-az2",
    "euc1-az3"
  ],
  "eu-west-1" = [
    "euw1-az1",
    "euw1-az2",
    "euw1-az3"
  ]
}

public_subnet_size   = 3
private_subnet_size  = 3
database_subnet_size = 3

# EKS
instance_types = {
  "dev"     = ["t3.small"]
  "staging" = ["t3.medium"]
  "prod"    = ["t3.large"]
}
capacity_type = {
  "dev"     = "SPOT"
  "staging" = "ONDEMAND"
  "prod"    = "ONDEMAND"
}
cluster_addons_versions = {
  coredns    = "v1.11.1-eksbuild.9"
  kube-proxy = "v1.30.0-eksbuild.3"
  vpc-cni    = "v1.18.2-eksbuild.1"
}

# DB
instance_class = {
  "dev"     = "db.t3.micro"
  "staging" = "db.t3.medium"
  "prod"    = "db.t3.large"
}
engine_version = {
  "dev"     = "8.0"
  "staging" = "8.0"
  "prod"    = "8.0"
}

# Bastion
bastion_instance_type = "t3.medium"