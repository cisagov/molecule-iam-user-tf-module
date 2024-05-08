output "access_key" {
  description = "The IAM access key associated with the CI IAM user created by this module."
  sensitive   = true
  value       = module.ci_user.access_key
}

output "production_role" {
  description = "The IAM role that the CI user can assume to read SSM parameters in the production account."
  value       = module.ci_user.production_role
}

output "staging_role" {
  description = "The IAM role that the CI user can assume to read SSM parameters in the staging account."
  value       = module.ci_user.staging_role
}

output "user" {
  description = "The CI IAM user created by this module."
  value       = module.ci_user.user
}
