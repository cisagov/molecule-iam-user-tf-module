module "ci_user" {
  source = "github.com/cisagov/ci-iam-user-tf-module"

  providers = {
    aws            = aws
    aws.production = aws.images-production-provisionaccount
    aws.staging    = aws.images-staging-provisionaccount
  }

  role_description = local.role_description
  role_name        = local.role_name
  user_name        = local.user_name
  tags             = var.tags
}

# Attach the AWS SSM Parameter Store read role policies to the CI
# production and staging roles
resource "aws_iam_role_policy_attachment" "ssm_staging_attachment" {
  provider = aws.images-staging-provisionaccount

  policy_arn = module.parameterstorereadonly_role_staging.policy.arn
  role       = module.ci_user.staging_role.name
}
resource "aws_iam_role_policy_attachment" "ssm_production_attachment" {
  provider = aws.images-production-provisionaccount

  policy_arn = module.parameterstorereadonly_role_production.policy.arn
  role       = module.ci_user.production_role.name
}
