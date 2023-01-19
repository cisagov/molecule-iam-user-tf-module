# ------------------------------------------------------------------------------
# Create the IAM roles that allow read-only access to the specified SSM
# Parameter Store parameters in the Images accounts (Production and Staging).
# ------------------------------------------------------------------------------

# Get the default caller identity, which corresponds to the Users account.
# This is needed to determine the Users account ID.
data "aws_caller_identity" "users" {
}

module "parameterstorereadonly_role_production" {
  source = "github.com/cisagov/ssm-read-role-tf-module"

  providers = {
    aws = aws.images-production-ssm
  }

  account_ids   = [data.aws_caller_identity.users.account_id]
  entity_name   = var.entity
  iam_usernames = [module.ci_user.user.name]
  role_name     = "ParameterStoreReadOnly-%s-Production"
  ssm_names     = var.ssm_parameters
}

module "parameterstorereadonly_role_staging" {
  source = "github.com/cisagov/ssm-read-role-tf-module"

  providers = {
    aws = aws.images-staging-ssm
  }

  account_ids   = [data.aws_caller_identity.users.account_id]
  entity_name   = var.entity
  iam_usernames = [module.ci_user.user.name]
  role_name     = "ParameterStoreReadOnly-%s-Staging"
  ssm_names     = var.ssm_parameters
}
