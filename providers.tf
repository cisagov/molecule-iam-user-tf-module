# This is the provider that is used to create the role that can be
# assumed to perform CI functions.
provider "aws" {
  alias = "images-production-provisionaccount"
}

# This is the provider that is used to create the role that can be
# assumed to perform CI functions.
provider "aws" {
  alias = "images-staging-provisionaccount"
}

# This is the provider that is used to create the role and policy that can
# read Parameter Store parameters inside the Images Production account
provider "aws" {
  alias = "images-production-ssm"
}

# This is the provider that is used to create the role and policy that can
# read Parameter Store parameters inside the Images Staging account
provider "aws" {
  alias = "images-staging-ssm"
}
