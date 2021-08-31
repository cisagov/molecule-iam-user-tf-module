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

- [Basic usage](https://github.com/cisagov/molecule-iam-user-tf-module/tree/develop/examples/basic_usage)

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 0.13.0 |
| aws | ~> 3.38 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.38 |
| aws.images-production-provisionaccount | ~> 3.38 |
| aws.images-staging-provisionaccount | ~> 3.38 |

## Modules ##

| Name | Source | Version |
|------|--------|---------|
| ci\_user | github.com/cisagov/ci-iam-user-tf-module |  |
| parameterstorereadonly\_role\_production | github.com/cisagov/ssm-read-role-tf-module |  |
| parameterstorereadonly\_role\_staging | github.com/cisagov/ssm-read-role-tf-module |  |

## Resources ##

| Name | Type |
|------|------|
| [aws_iam_role_policy_attachment.ssm_production_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm_staging_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user_policy.assume_parameterstorereadonly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_caller_identity.users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_parameterstorereadonly_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| entity | The name of the entity (usually a GitHub repository) being tested (e.g. molecule-iam-user-tf-module). | `string` | n/a | yes |
| ssm\_parameters | The AWS SSM parameters that the IAM user needs to be able to read (e.g. ["/example/parameter1", "/example/config/*"]). | `list(string)` | n/a | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| access\_key | The IAM access key associated with the CI IAM user created by this module. |
| production\_role | The IAM role that the CI user can assume to read SSM parameters in the production account. |
| staging\_role | The IAM role that the CI user can assume to read SSM parameters in the staging account. |
| user | The CI IAM user created by this module. |

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, these are the main directory and
every directory under `examples/`.

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
