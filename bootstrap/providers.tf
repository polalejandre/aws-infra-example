provider "aws" {
  profile = "projectname-root"
  region  = "eu-central-1"
}

provider "aws" {
  profile = "projectname-root"
  alias   = "replica"
  region  = "eu-west-1"
}
