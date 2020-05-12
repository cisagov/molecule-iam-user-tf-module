# Default AWS provider
provider "aws" {
  region  = "us-east-1"
  profile = "account_1"
}

# Provider from some other AWS account
provider "aws" {
  region  = "us-east-1"
  profile = "account_2"
  alias   = "account_2"
}

# Provider from yet another AWS account
provider "aws" {
  region  = "us-east-1"
  profile = "account_3"
  alias   = "account_3"
}

module "parent" {
  source = "./parent"

  providers = {
    aws           = aws
    aws.account_2 = aws.account_2
    aws.account_3 = aws.account_3
  }
}

output "account_1_id" {
  value       = module.parent.default_acct_id
  description = "The account ID from the default provider, according to the parent module."
}

output "account_2_id" {
  value       = module.parent.child_acct_2_id
  description = "The account ID from the provider passed to the child_acct_2 module, according to the parent module."
}

output "account_3_id" {
  value       = module.parent.child_acct_3_id
  description = "The account ID from the provider passed to the child_acct_3 module, according to the parent module."
}

output "child_2_policy" {
  value = module.parent.child_2_policy
}

output "child_3_policy" {
  value = module.parent.child_3_policy
}
