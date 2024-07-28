provider "aws" {
  profile = "example-${local.env}"
  region  = "eu-central-1"

  default_tags {
    tags = local.default_tags
  }
}