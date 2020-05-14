locals {
  user_name        = format("test-%s", var.entity)
  role_name        = format("Test-%s", var.entity)
  role_description = format("A role that can be assumed to allow for CI testing of %s via Molecule.", var.entity)
}
