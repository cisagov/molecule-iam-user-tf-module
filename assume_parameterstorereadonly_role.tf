# IAM policy document that allows assumption of the ParameterStoreReadOnly
# role in the Images account for this user
data "aws_iam_policy_document" "assume_parameterstorereadonly_role_doc" {
  count = local.ssm_needed

  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]
    effect = "Allow"
    resources = [
      module.parameterstorereadonly_role[0].role.arn
    ]
  }
}

moved {
  from = data.aws_iam_policy_document.assume_parameterstorereadonly_role_doc
  to   = data.aws_iam_policy_document.assume_parameterstorereadonly_role_doc[0]
}

# The IAM policy allowing this user to assume their custom
# ParameterStoreReadOnly role in the Images account
resource "aws_iam_user_policy" "assume_parameterstorereadonly" {
  count = local.ssm_needed

  name   = "Images-Assume${module.parameterstorereadonly_role[0].role.name}"
  policy = data.aws_iam_policy_document.assume_parameterstorereadonly_role_doc[0].json
  user   = module.ci_user.user.name
}

moved {
  from = aws_iam_user_policy.assume_parameterstorereadonly
  to   = aws_iam_user_policy.assume_parameterstorereadonly[0]
}
