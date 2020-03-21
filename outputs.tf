output "access_key" {
  value       = aws_iam_access_key.key
  description = "The IAM access key associated with the IAM user created by this module."
  sensitive   = true
}

output "user" {
  value       = aws_iam_user.user
  description = "The IAM user created by this module."
}
