locals {
  role_description = format("A role that can be assumed to allow for CI testing of %s via Molecule.", var.entity)
  role_name        = format("Test-%s", var.entity)

  # Determine if the CI user needs to be able to read SSM parameters
  ssm_needed = length(var.ssm_parameters) > 0 ? 1 : 0

  user_name = format("test-%s", var.entity)
}
