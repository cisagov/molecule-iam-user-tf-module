# molecule-iam-user-tf-module #

[![GitHub Build Status](https://github.com/cisagov/molecule-iam-user-tf-module/workflows/build/badge.svg)](https://github.com/cisagov/molecule-iam-user-tf-module/actions)

A Terraform module for creating an IAM user suitable for use in molecule
testing of an Ansible role.

## Usage ##

### Multi-Account Usage ###

```hcl
module "example" {
  source = "github.com/cisagov/molecule-iam-user-tf-module"

  providers = {
    aws                   = aws
    aws.images-production = aws.images-production
    aws.images-staging    = aws.images-staging
  }

  ssm_parameters = ["/example/parameter1", "/example/config/*"]
  user_name      = "test-molecule-iam-user-tf-module"

  tags = {
    Team        = "VM Fusion - Development"
    Application = "molecule-iam-user-tf-module testing"
  }
}
```

### Single Account Usage ###

```hcl
module "example" {
  source = "github.com/cisagov/molecule-iam-user-tf-module"

  providers = {
    aws                   = aws
    aws.images-production = aws
    aws.images-staging    = aws
  }

  ssm_parameters = ["/example/parameter1", "/example/config/*"]
  user_name      = "test-molecule-iam-user-tf-module"

  tags = {
    Team        = "VM Fusion - Development"
    Application = "molecule-iam-user-tf-module testing"
  }
}
```

#### Single Account Caveats ####

This module is designed to create the role and associated policies in two
accounts: staging and production. When run with a single account, you will
receive errors when it tries to create the role and policies in the second
internal provider as seen here:

```console
Error: Error creating IAM policy ParameterStoreReadOnly-test-molecule-iam-user-tf-module: EntityAlreadyExists: A policy called ParameterStoreReadOnly-test-molecule-iam-user-tf-module already exists. Duplicate names are not allowed.
  status code: 409, request id: <removed>

  on .terraform/modules/iam_user.parameterstorereadonly_role_production/policy.tf line 21, in resource "aws_iam_policy" "ssm_policy":
  21: resource "aws_iam_policy" "ssm_policy" {

Error: Error creating IAM Role ParameterStoreReadOnly-test-molecule-iam-user-tf-module: EntityAlreadyExists: Role with name ParameterStoreReadOnly-test-molecule-iam-user-tf-module already exists.
  status code: 409, request id: <removed>

  on .terraform/modules/iam_user.parameterstorereadonly_role_production/role.tf line 25, in resource "aws_iam_role" "ssm_role":
  25: resource "aws_iam_role" "ssm_role" {
```

In this case these errors are expected and can be safely ignored.

## Examples ##

* [Create an AWS IAM user capable of reading SSM Parameter Store parameters](https://github.com/cisagov/molecule-iam-user-tf-module/tree/develop/examples/basic_usage)

## Providers ##

| Name | Version |
|------|---------|
| aws | n/a |
| aws.images-production-provisionaccount | n/a |
| aws.images-staging-provisionaccount | n/a |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| entity | The name of the entity (usually a GitHub repository) being tested (e.g. molecule-iam-user-tf-module). | `string` | n/a | yes |
| ssm_parameters | The AWS SSM parameters that the IAM user needs to be able to read (e.g. ["/example/parameter1", "/example/config/*"]). | `list(string)` | n/a | yes |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| access_key | The IAM access key associated with the CI IAM user created by this module. |
| production_role | The IAM role that the CI user can assume to read SSM parameters in the production account. |
| staging_role | The IAM role that the CI user can assume to read SSM parameters in the staging account. |
| user | The CI IAM user created by this module. |

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, these are the main directory and
every directory under `examples/`.

## Contributing ##

We welcome contributions!  Please see [here](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
