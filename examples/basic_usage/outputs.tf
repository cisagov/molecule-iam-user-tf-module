output "access_key" {
  value       = module.iam_user.access_key
  description = "The IAM access key for the test-molecule-iam-user-tf-module user."
  # sensitive   = true
}

output "user" {
  value       = module.iam_user.user
  description = "The test-molecule-iam-user-tf-module IAM user."
}
