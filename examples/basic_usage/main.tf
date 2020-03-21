# Default AWS provider (ProvisionAccount for the Users account)
provider "aws" {
  region  = "us-east-1"
  profile = "cool-users-provisionaccount"
}

# ProvisionParameterStoreReadRoles AWS provider for the
# Images (Production) account
provider "aws" {
  region  = "us-east-1"
  profile = "cool-images-production-provisionparameterstorereadroles"
  alias   = "images-production"
}

# ProvisionParameterStoreReadRoles AWS provider for the
# Images (Staging) account
provider "aws" {
  region  = "us-east-1"
  profile = "cool-images-staging-provisionparameterstorereadroles"
  alias   = "images-staging"
}

module "iam_user" {
  source = "../.."

  providers = {
    aws                   = aws
    aws.images-production = aws.images-production
    aws.images-staging    = aws.images-staging
  }

  ssm_parameters = ["/example/parameter1", "/example/config/*"]
  user_name      = "test-molecule-iam-user-tf-module"

  tags = {
    Team        = "VM Fusion - Development"
    Application = "molecule-iam-user-tf-module testing"
  }
}
