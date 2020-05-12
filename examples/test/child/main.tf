# Default AWS provider
provider "aws" {
}

data "aws_caller_identity" "child" {
}

# IAM policy document that that allows for reading the SSM parameters
data "aws_iam_policy_document" "ssm_doc" {
  statement {
    effect = "Allow"

    actions = [
      "ssm:GetParameters",
      "ssm:GetParameter"
    ]

    # calculate all the combinations of regions, accounts, and names
    resources = [for t in setproduct(["us-east-1", "us-east-2"], [data.aws_caller_identity.child.account_id], ["/test"]) : format("arn:aws:ssm:${t[0]}:${t[1]}:parameter${t[2]}")]
  }
}

output "child_account_id" {
  value       = data.aws_caller_identity.child.account_id
  description = "The account ID from the default provider."
}

output "ssm_doc" {
  value       = data.aws_iam_policy_document.ssm_doc
  description = "A test policy doc."
}
