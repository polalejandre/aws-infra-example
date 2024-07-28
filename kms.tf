resource "aws_kms_key" "kms" {
  description = "KMS key for Example Project"
}

resource "aws_kms_key_policy" "kms" {
  key_id = aws_kms_key.kms.id
  policy = jsonencode({
    Id = "example"
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }

        Resource = "*"
        Sid      = "Enable IAM User Permissions"
      },
    ]
    Version = "2012-10-17"
  })
}
