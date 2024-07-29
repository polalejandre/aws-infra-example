# Terraform AWS Infrastructure Project

This project uses Terraform to create and manage a base infrastructure on AWS. The infrastructure includes networks, subnets, a database with stored secrets, a private EKS cluster, KMS keys for encryption, and a bastion host with SSM enabled.

The initial config is created in the bootsrap folder, so that config need to be applied first!

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Architecture Overview](#architecture-overview)
3. [Components](#components)
    - [Network](#network)
    - [Database](#database)
    - [EKS Cluster](#eks-cluster)
    - [KMS Keys](#kms-keys)
    - [Bastion Host](#bastion-host)
4. [Usage](#usage)
    - [Installation](#installation)
    - [Configuration](#configuration)
    - [Deployment](#deployment)
    - [Cleanup](#cleanup)
5. [Contributing](#contributing)
6. [License](#license)

## Prerequisites

Before you begin, ensure you have the following installed:
- [Terraform](https://www.terraform.io/downloads.html) v1.8.5 or later
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate IAM permissions
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) for EKS management

## Architecture Overview

The infrastructure created by this project includes the following components:

- **VPC**: A Virtual Private Cloud to host all resources.
- **Subnets**: Public, private, and database subnets.
- **Internet Gateway**: For internet access to public subnets.
- **NAT Gateway**: For internet access to private subnets.
- **RDS**: A relational database instance with secrets stored in AWS Systems Manager Parameter Store.
- **EKS**: A private Elastic Kubernetes Service cluster.
- **KMS**: Key Management Service for encryption.
- **Bastion Host**: An EC2 instance with SSM enabled for secure access to private resources.

## Components

### Network

- **VPC**: A Virtual Private Cloud to isolate our resources.
- **Subnets**:
  - **Public Subnet**: For resources that need internet access.
  - **Private Subnet**: For internal resources.
  - **Database Subnet**: For RDS instances.
- **Route Tables and Routes**:
  - **Public Route Table**: Routes internet traffic through the Internet Gateway.
  - **Private Route Table**: Routes traffic through the NAT Gateway.
- **Internet Gateway**: Provides internet access to the VPC.
- **NAT Gateway**: Allows instances in the private subnet to access the internet.

### Database

- **RDS Instance**: A relational database instance.
- **Secrets Management**: Store database credentials and other secrets in AWS Systems Manager Parameter Store, encrypted using KMS keys.

### EKS Cluster

- **EKS Cluster**: A private Elastic Kubernetes Service cluster for deploying containerized applications.
- **Node Groups**: Managed node groups for the EKS cluster.

### KMS Keys

- **KMS Keys**: Used to encrypt sensitive data, including secrets in Parameter Store and EBS volumes.

### Bastion Host

- **Bastion Host**: An EC2 instance in the public subnet with SSM agent enabled for secure access to private resources.

## Usage

### Installation

Clone the repository and navigate to the project directory:

```bash
git clone https://github.com/polalejandre/aws-infra-example.git
cd terraform-aws-infrastructure
```

### Configuration

1. Set the bucket names in "bootstrap" folder in order to create the bucket for the remote states, and apply the config.

2. Create a `terraform.tfvars` file in the project directory and specify the required variables. These are the variables used for this example:

```hcl
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
```

### Deployment

Initialize the Terraform workspace and apply the configuration:

```bash
terraform init
terraform apply
```

### Cleanup

To destroy all the resources created by this project:

```bash
terraform destroy
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

By following this README, you should be able to set up and manage a comprehensive AWS infrastructure using Terraform. If you have any issues or questions, please refer to the official documentation or open an issue in this repository.



