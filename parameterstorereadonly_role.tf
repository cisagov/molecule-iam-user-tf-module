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
    aws = aws.images-production
  }

  account_ids  = [data.aws_caller_identity.users.account_id]
  entity_name  = var.user_name
  iam_username = var.user_name
  ssm_names    = var.ssm_parameters
}

module "parameterstorereadonly_role_staging" {
  source = "github.com/cisagov/ssm-read-role-tf-module"

  providers = {
    aws = aws.images-staging
  }

  account_ids  = [data.aws_caller_identity.users.account_id]
  entity_name  = var.user_name
  iam_username = var.user_name
  ssm_names    = var.ssm_parameters
}
