# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "entity" {
  type        = string
  description = "The name of the entity (usually a GitHub repository) being tested (e.g. molecule-iam-user-tf-module)."
}

variable "ssm_parameters" {
  type        = list(string)
  description = "The AWS SSM parameters that the IAM user needs to be able to read (e.g. [\"/example/parameter1\", \"/example/config/*\"])."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------
