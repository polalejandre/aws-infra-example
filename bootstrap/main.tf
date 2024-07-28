module "remote_state" {
  providers = {
    aws         = aws
    aws.replica = aws.replica
  }

  source  = "nozaq/remote-state-s3-backend/aws"
  version = "1.6.0"

  override_s3_bucket_name       = true
  s3_bucket_name                = "example-tfstates"
  s3_bucket_name_replica        = "example-tfstates-replica"
  noncurrent_version_expiration = { days = 30 }
  enable_replication            = false

  dynamodb_table_name                    = "example-state-lock"
  dynamodb_enable_server_side_encryption = true

  kms_key_alias               = "example-state-lock"
  kms_key_enable_key_rotation = false
}

# We do this on our own BELOW given module does not leverage key cache as of 1.5.0
resource "aws_s3_bucket_server_side_encryption_configuration" "state" {
  bucket = module.remote_state.state_bucket.bucket

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = module.remote_state.kms_key.arn
    }
  }
}
