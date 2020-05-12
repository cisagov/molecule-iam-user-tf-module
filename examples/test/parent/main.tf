# Default AWS provider
provider "aws" {
  region = "us-east-1"
}

# Provider from some other AWS account
provider "aws" {
  alias = "account_2"
}

# Provider from yet another AWS account
provider "aws" {
  alias = "account_3"
}

module "child_acct_2" {
  source = "../child"

  providers = {
    aws = aws.account_2
  }
}

module "child_acct_3" {
  source = "../child"

  providers = {
    aws = aws.account_3
  }
}

data "aws_caller_identity" "parent" {
}

output "default_acct_id" {
  value       = data.aws_caller_identity.parent.account_id
  description = "The account ID from the default provider."
}

output "child_acct_2_id" {
  value       = module.child_acct_2.child_account_id
  description = "The account ID from the provider passed to the child_acct_2 module."
}

output "child_acct_3_id" {
  value       = module.child_acct_3.child_account_id
  description = "The account ID from the provider passed to the child_acct_3 module."
}

output "child_2_policy" {
  value = module.child_acct_2.ssm_doc
}

output "child_3_policy" {
  value = module.child_acct_3.ssm_doc
}
