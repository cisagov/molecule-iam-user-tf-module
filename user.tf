# ------------------------------------------------------------------------------
# Create an IAM user and an associated access key
# ------------------------------------------------------------------------------

# The IAM user being created
resource "aws_iam_user" "user" {
  name = var.user_name
  tags = var.tags
}

# The IAM access key for the user
resource "aws_iam_access_key" "key" {
  user = aws_iam_user.user.name
}
