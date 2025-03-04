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

# ProvisionAccount AWS provider for the Images account
provider "aws" {
  alias = "images-provisionaccount"
  default_tags {
    tags = local.tags
  }
  profile = "cool-images-provisionaccount"
  region  = "us-east-1"
}

# ProvisionParameterStoreReadRoles AWS provider for the Images account
provider "aws" {
  alias = "images-ssm"
  default_tags {
    tags = local.tags
  }
  profile = "cool-images-provisionparameterstorereadroles"
  region  = "us-east-1"
}


module "iam_user" {
  source = "../.."

  providers = {
    aws                         = aws
    aws.images-provisionaccount = aws.images-provisionaccount
    aws.images-ssm              = aws.images-ssm
  }

  entity         = "molecule-iam-user-tf-module"
  ssm_parameters = ["/example/parameter1", "/example/config/*"]
}
