output "access_key" {
  description = "The IAM access key for the test-molecule-iam-user-tf-module user."
  sensitive   = true
  value       = module.iam_user.access_key
}

output "user" {
  description = "The test-molecule-iam-user-tf-module IAM user."
  value       = module.iam_user.user
}
