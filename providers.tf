# This is the default provider that is used to create resources inside
# the Users account
provider "aws" {
  region = "us-east-1"
}

# This is the provider that is used to create the role and policy that can
# read Parameter Store parameters inside the Images Production account
provider "aws" {
  region = "us-east-1"
  alias  = "images-production"
}

# This is the provider that is used to create the role and policy that can
# read Parameter Store parameters inside the Images Staging account
provider "aws" {
  region = "us-east-1"
  alias  = "images-staging"
}
