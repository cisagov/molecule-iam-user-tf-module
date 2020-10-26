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
    aws                                    = aws
    aws.images-production-provisionaccount = aws.images-production-provisionaccount
    aws.images-staging-provisionaccount    = aws.images-staging-provisionaccount
    aws.images-production-ssm              = aws.images-production-ssm
    aws.images-staging-ssm                 = aws.images-staging-ssm
  }

  entity         = "my-repo"
  ssm_parameters = ["/example/parameter1", "/example/config/*"]
  user_name      = "test-my-repo"

  tags = {
    Team        = "VM Fusion - Development"
    Application = "my-repo testing"
  }
}
```

### Single Account Usage ###

```hcl
module "example" {
  source = "github.com/cisagov/molecule-iam-user-tf-module"

  providers = {
    aws                                    = aws
    aws.images-production-provisionaccount = aws
    aws.images-staging-provisionaccount    = aws
    aws.images-production-ssm              = aws
    aws.images-staging-ssm                 = aws
  }

  entity         = "my-repo"
  ssm_parameters = ["/example/parameter1", "/example/config/*"]
  user_name      = "test-my-repo"

  tags = {
    Team        = "VM Fusion - Development"
    Application = "my-repo testing"
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

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 3.0 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.0 |
| aws.images-production-provisionaccount | ~> 3.0 |
| aws.images-staging-provisionaccount | ~> 3.0 |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
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

## New Repositories from a Skeleton ##

Please see our [Project Setup guide](https://github.com/cisagov/development-guide/tree/develop/project_setup)
for step-by-step instructions on how to start a new repository from
a skeleton. This will save you time and effort when configuring a
new repository!

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
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
