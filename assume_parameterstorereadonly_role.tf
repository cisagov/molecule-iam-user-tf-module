# IAM policy document that allows assumption of the ParameterStoreReadOnly
# role in the Images accounts (Production and Staging) for this user
data "aws_iam_policy_document" "assume_parameterstorereadonly_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      module.parameterstorereadonly_role_production.role.arn,
      module.parameterstorereadonly_role_staging.role.arn
    ]
  }
}

# The IAM policy allowing this user to assume their custom
# ParameterStoreReadOnly role in the Images accounts (Production and Staging)
resource "aws_iam_user_policy" "assume_parameterstorereadonly" {
  name   = "Images-Assume${module.parameterstorereadonly_role_production.role.name}"
  user   = aws_iam_user.user.name
  policy = data.aws_iam_policy_document.assume_parameterstorereadonly_role_doc.json
}
