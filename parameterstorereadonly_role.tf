# ------------------------------------------------------------------------------
# Create the IAM role that allows read-only access to the specified SSM
# Parameter Store parameters in the Images account.
# ------------------------------------------------------------------------------

# Get the default caller identity, which corresponds to the Users account.
# This is needed to determine the Users account ID.
data "aws_caller_identity" "users" {
}

module "parameterstorereadonly_role" {
  count  = local.ssm_needed
  source = "github.com/cisagov/ssm-read-role-tf-module"

  providers = {
    aws = aws.images-ssm
  }

  account_ids   = [data.aws_caller_identity.users.account_id]
  entity_name   = var.entity
  iam_usernames = [module.ci_user.user.name]
  role_name     = "ParameterStoreReadOnly-%s"
  ssm_names     = var.ssm_parameters
}

moved {
  from = module.parameterstorereadonly_role
  to   = module.parameterstorereadonly_role[0]
}
