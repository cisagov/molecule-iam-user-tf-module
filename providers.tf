# Default AWS region to use for the AWS providers.
# This is needed to supply `terraform validate` with all of the required
# parameters it needs to check the code.
locals {
  aws_region = "us-east-1"
}

# This is the default provider that is used to create resources inside
# the Users account
provider "aws" {
  region = local.aws_region
}

# This is the provider that is used to create the role and policy that can
# read Parameter Store parameters inside the Images Production account
provider "aws" {
  region = local.aws_region
  alias  = "images-production"
}

# This is the provider that is used to create the role and policy that can
# read Parameter Store parameters inside the Images Staging account
provider "aws" {
  region = local.aws_region
  alias  = "images-staging"
}
