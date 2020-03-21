# This is the default provider that is used to create resources inside
# the Users account
provider "aws" {
}

# This is the provider that is used to create the policy that can
# read Parameter Store parameters inside the Images Production account
provider "aws" {
  alias = "images-production"
}

# This is the provider that is used to create the policy that can
# read Parameter Store parameters inside the Images Staging account
provider "aws" {
  alias = "images-staging"
}
