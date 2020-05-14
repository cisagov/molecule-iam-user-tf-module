# Default AWS provider (ProvisionAccount for the Users account)
provider "aws" {
  region  = "us-east-1"
  profile = "cool-users-provisionaccount"
}

# ProvisionParameterStoreReadRoles AWS provider for the
# Images (Production) account
provider "aws" {
  region  = "us-east-1"
  profile = "cool-images-production-provisionaccount"
  alias   = "images-production-provisionaccount"
}

# ProvisionParameterStoreReadRoles AWS provider for the
# Images (Staging) account
provider "aws" {
  region  = "us-east-1"
  profile = "cool-images-staging-provisionaccount"
  alias   = "images-staging-provisionaccount"
}

# ProvisionParameterStoreReadRoles AWS provider for the
# Images (Production) account
provider "aws" {
  region  = "us-east-1"
  profile = "cool-images-production-provisionparameterstorereadroles"
  alias   = "images-production-ssm"
}

# ProvisionParameterStoreReadRoles AWS provider for the
# Images (Staging) account
provider "aws" {
  region  = "us-east-1"
  profile = "cool-images-staging-provisionparameterstorereadroles"
  alias   = "images-staging-ssm"
}

module "iam_user" {
  source = "../.."

  providers = {
    aws                                    = aws
    aws.images-production-provisionaccount = aws.images-production-provisionaccount
    aws.images-staging-provisionaccount    = aws.images-staging-provisionaccount
    aws.images-production-ssm              = aws.images-production-ssm
    aws.images-staging-ssm                 = aws.images-staging-ssm
  }

  entity         = "molecule-iam-user-tf-module"
  ssm_parameters = ["/example/parameter1", "/example/config/*"]

  tags = {
    Team        = "VM Fusion - Development"
    Application = "molecule-iam-user-tf-module testing"
  }
}
