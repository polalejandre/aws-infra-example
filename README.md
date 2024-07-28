# Terraform AWS Infrastructure Project

This project uses Terraform to create and manage a complete infrastructure on AWS. The infrastructure includes networks, subnets, a database with stored secrets, a private EKS cluster, KMS keys for encryption, and a bastion host with SSM enabled.

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
- [Terraform](https://www.terraform.io/downloads.html) v1.0 or later
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
git clone https://github.com/your-repo/terraform-aws-infrastructure.git
cd terraform-aws-infrastructure
```

### Configuration

Create a `terraform.tfvars` file in the project directory and specify the required variables:

```hcl
aws_region       = "us-west-2"
vpc_cidr         = "10.0.0.0/16"
public_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]
database_subnets = ["10.0.5.0/24", "10.0.6.0/24"]
eks_cluster_name = "my-eks-cluster"
db_username      = "admin"
db_password      = "your-secure-password"
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



