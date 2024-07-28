variable "availability_zones" {
  type        = map(list(string))
  description = "Availability zones"
}

# Networking
variable "vpc_cidr" {
  type        = map(map(string))
  description = "VPC CIDR"
}

variable "public_subnet_size" {
  type        = number
  description = "Size of subnets relative to base CIDR / 2 (bits to the right)"
}

variable "private_subnet_size" {
  type        = number
  description = "Size of subnets relative to base CIDR / 2 (bits to the right)"
}

variable "database_subnet_size" {
  type        = number
  description = "Size of subnets relative to base CIDR / 2 (bits to the right)"
}

# EKS
variable "instance_types" {
  type        = map(list(string))
  description = "Instance type"
}
variable "capacity_type" {
  type        = map(string)
  description = "Capacity type"
}
variable "cluster_addons_versions" {
  type        = map(string)
  description = "Cluster addons versions"
}

# DB
variable "instance_class" {
  type        = map(string)
  description = "Class of the DB instance"
}

variable "engine_version" {
  type        = map(string)
  description = "Version of the DB engine"
}

# Bastion
variable "bastion_instance_type" {
  type        = string
  description = "Type of the bastion instance"
}