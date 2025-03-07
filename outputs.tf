output "access_key" {
  description = "The IAM access key associated with the CI IAM user created by this module."
  sensitive   = true
  value       = module.ci_user.access_key
}

output "role" {
  description = "The IAM role that the CI user can assume to perform testing."
  value       = module.ci_user.role
}

output "user" {
  description = "The CI IAM user created by this module."
  value       = module.ci_user.user
}
