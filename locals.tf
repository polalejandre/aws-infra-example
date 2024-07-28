locals {
  # Workspaces are named as "<env>-<region>"
  # where <env> is one of "dev", "qa", "staging", "prod", or the name of the account like "general-purpose"
  # and <region> is "us-east-1" only for now

  # List of known AWS regions
  aws_regions = [
    "eu-central-1",
    "eu-west-1"
  ]

  # Find the region by checking if the workspace ends with a known AWS region
  region = [for region in local.aws_regions : region if endswith(terraform.workspace, region)][0]

  # Length of the region part including the preceding dash
  region_length_with_dash = length(local.region) + 1

  # Extract the env part from the workspace name
  env = substr(terraform.workspace, 0, length(terraform.workspace) - local.region_length_with_dash)

  ## Project name
  project = "example"
  name    = "${local.project}-${local.env}"

  # To control whether we are creating resources from scratch or not
  bootstrapping = false // local.on_qa

  # Default tags for all resources
  default_tags = {
    "example:service:env" = local.env
    "terraform"           = "true"
  }

  ## Workspace-specific
  on_dev      = local.env == "dev"
  not_on_dev  = !local.on_dev
  on_prod     = local.env == "prod"
  not_on_prod = !local.on_prod

  ## Networking
  public_subnet_cidr   = cidrsubnet(var.vpc_cidr[local.env][local.region], 2, 0)
  private_subnet_cidr  = cidrsubnet(var.vpc_cidr[local.env][local.region], 2, 1)
  database_subnet_cidr = cidrsubnet(var.vpc_cidr[local.env][local.region], 2, 2)
  # Subnets are /20 if sizes are set in 3 (4096 IPs)
  public_subnets = [
    for i in range(length(var.availability_zones[local.region])) : (
      cidrsubnet(local.public_subnet_cidr, var.public_subnet_size, i)
  )]
  private_subnets = [
    for i in range(length(var.availability_zones[local.region])) : (
      cidrsubnet(local.private_subnet_cidr, var.private_subnet_size, i)
  )]
  database_subnets = [
    for i in range(length(var.availability_zones[local.region])) : (
      cidrsubnet(local.database_subnet_cidr, var.database_subnet_size, i)
  )]

  # Route propagation
  route_table_ids = concat(
    module.vpc.public_route_table_ids,
    module.vpc.private_route_table_ids
  )
  # On QA and prod we have 6 RTs, 4 private, 1 public and 1 default
  # On dev we have 1 private, 1 public, 1 default
  route_table_num = local.on_dev ? 3 : 6
}
