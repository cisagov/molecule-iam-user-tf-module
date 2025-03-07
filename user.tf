module "ci_user" {
  source = "github.com/cisagov/ci-iam-user-tf-module"

  providers = {
    aws    = aws
    aws.ci = aws.images-provisionaccount
  }

  role_description = local.role_description
  role_name        = local.role_name
  user_name        = local.user_name
}

# Attach the AWS SSM Parameter Store read role policy to the CI role
resource "aws_iam_role_policy_attachment" "ssm" {
  count    = local.ssm_needed
  provider = aws.images-provisionaccount

  policy_arn = module.parameterstorereadonly_role[0].policy.arn
  role       = module.ci_user.role.name
}
