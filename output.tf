output "public" {
  value = local.public_subnets
}

output "private" {
  value = local.private_subnets
}

output "database" {
  value = local.database_subnets
}

output "github_oidc_role" {
  value = module.github_oidc.oidc_role
}

output "kms_key" {
  value = aws_kms_key.kms.id
}