resource "random_password" "password" {
  length  = 16
  special = true
}

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = local.name

  engine            = "mysql"
  engine_version    = var.engine_version[local.env]
  instance_class    = var.instance_class[local.env]
  allocated_storage = 20

  family               = "mysql8.0"
  major_engine_version = var.engine_version[local.env]

  db_name  = "example"
  username = "example"
  password = random_password.password.result

  iam_database_authentication_enabled = true

  db_subnet_group_name   = module.vpc.database_subnet_group_name
  subnet_ids             = module.vpc.database_subnets
  vpc_security_group_ids = [aws_security_group.db.id]
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/db/password"
  type  = "SecureString"
  value = random_password.password.result
}

resource "aws_security_group" "db" {
  name   = "db"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.eks.id]
  }
}
