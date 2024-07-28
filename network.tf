module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.3"

  name = local.name
  cidr = var.vpc_cidr[local.env][local.region]
  azs  = var.availability_zones[local.region]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  public_subnets = local.public_subnets

  public_dedicated_network_acl = true

  public_inbound_acl_rules = [
    {
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 0,
      "protocol" : "tcp",
      "rule_action" : "allow",
      "rule_number" : 100,
      "to_port" : 65535
    }
  ]
  public_outbound_acl_rules = [
    {
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 0,
      "protocol" : "-1",
      "rule_action" : "allow",
      "rule_number" : 100,
      "to_port" : 0
    }
  ]

  private_subnets = local.private_subnets

  private_dedicated_network_acl = true

  private_inbound_acl_rules = [
    {
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 0,
      "protocol" : "-1",
      "rule_action" : "allow",
      "rule_number" : 100,
      "to_port" : 0
    }
  ]
  private_outbound_acl_rules = [
    {
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 0,
      "protocol" : "-1",
      "rule_action" : "allow",
      "rule_number" : 100,
      "to_port" : 0
    }
  ]

  database_subnets = local.database_subnets

  database_dedicated_network_acl = true

  database_inbound_acl_rules = [
    {
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 0,
      "protocol" : "-1",
      "rule_action" : "allow",
      "rule_number" : 100,
      "to_port" : 0
    }
  ]
  database_outbound_acl_rules = [
    {
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 0,
      "protocol" : "-1",
      "rule_action" : "allow",
      "rule_number" : 100,
      "to_port" : 0
    }
  ]

  #default_route_table_propagating_vgws = var.default_route_table_propagating_vgws[local.env]
  propagate_private_route_tables_vgw = true
  propagate_public_route_tables_vgw  = true
}
