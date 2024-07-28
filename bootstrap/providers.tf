provider "aws" {
  profile = "ticketgo-root"
  region  = "eu-central-1"
}

provider "aws" {
  profile = "ticketgo-root"
  alias   = "replica"
  region  = "eu-west-1"
}