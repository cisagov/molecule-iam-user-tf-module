# This is the provider that is used to create the role that can be
# assumed to perform CI functions.
provider "aws" {
  alias = "images-provisionaccount"
}


# This is the provider that is used to create the role and policy that can
# read Parameter Store parameters inside the Images account
provider "aws" {
  alias = "images-ssm"
}
