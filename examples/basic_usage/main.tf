locals {
  # Default tags to apply to all AWS resources created
  tags = {
    Team        = "VM Fusion - Development"
    Application = "molecule-iam-user-tf-module testing"
  }
}

# Default AWS provider (ProvisionAccount for the Users account)
provider "aws" {
  default_tags {
    tags = local.tags
  }
  profile = "cool-users-provisionaccount"
  region  = "us-east-1"
}

# ProvisionAccount AWS provider for the Images (Production) account
provider "aws" {
  alias = "images-production-provisionaccount"
  default_tags {
    tags = local.tags
  }
  profile = "cool-images-production-provisionaccount"
  region  = "us-east-1"
}

# ProvisionAccount AWS provider for the Images (Staging) account
provider "aws" {
  alias = "images-staging-provisionaccount"
  default_tags {
    tags = local.tags
  }
  profile = "cool-images-staging-provisionaccount"
  region  = "us-east-1"
}

# ProvisionParameterStoreReadRoles AWS provider for the
# Images (Production) account
provider "aws" {
  alias = "images-production-ssm"
  default_tags {
    tags = local.tags
  }
  profile = "cool-images-production-provisionparameterstorereadroles"
  region  = "us-east-1"
}

# ProvisionParameterStoreReadRoles AWS provider for the
# Images (Staging) account
provider "aws" {
  alias = "images-staging-ssm"
  default_tags {
    tags = local.tags
  }
  profile = "cool-images-staging-provisionparameterstorereadroles"
  region  = "us-east-1"
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
}
