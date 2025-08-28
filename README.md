# molecule-iam-user-tf-module #

[![GitHub Build Status](https://github.com/cisagov/molecule-iam-user-tf-module/workflows/build/badge.svg)](https://github.com/cisagov/molecule-iam-user-tf-module/actions)

A Terraform module for creating an IAM user suitable for use in [Molecule
testing](https://ansible.readthedocs.io/projects/molecule/) of an
[Ansible](https://www.redhat.com/en/ansible-collaborative) role.

## Usage ##

### Multi-provider usage ###

```hcl
module "example" {
  source = "github.com/cisagov/molecule-iam-user-tf-module?ref=v1.0.0"

  providers = {
    aws                         = aws
    aws.images-provisionaccount = aws.images-provisionaccount
    aws.images-ssm              = aws.images-ssm
  }

  entity         = "my-repo"
  ssm_parameters = ["/example/parameter1", "/example/config/*"]
}
```

### Single provider usage ###

```hcl
module "example" {
  source = "github.com/cisagov/molecule-iam-user-tf-module"

  providers = {
    aws                         = aws
    aws.images-provisionaccount = aws
    aws.images-ssm              = aws
  }

  entity         = "my-repo"
  ssm_parameters = ["/example/parameter1", "/example/config/*"]
}
```

## Examples ##

- [Basic usage](https://github.com/cisagov/molecule-iam-user-tf-module/tree/develop/examples/basic_usage)

<!-- BEGIN_TF_DOCS -->
## Requirements ##

| Name | Version |
|------|---------|
| terraform | >= 1.1 |
| aws | >= 4.9 |

## Providers ##

| Name | Version |
|------|---------|
| aws | >= 4.9 |
| aws.images-provisionaccount | >= 4.9 |

## Modules ##

| Name | Source | Version |
|------|--------|---------|
| ci\_user | github.com/cisagov/ci-iam-user-tf-module | n/a |
| parameterstorereadonly\_role | github.com/cisagov/ssm-read-role-tf-module | n/a |

## Resources ##

| Name | Type |
|------|------|
| [aws_iam_role_policy_attachment.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user_policy.assume_parameterstorereadonly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_caller_identity.users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_parameterstorereadonly_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| entity | The name of the entity (usually a GitHub repository) being tested (e.g. molecule-iam-user-tf-module). | `string` | n/a | yes |
| ssm\_parameters | The AWS SSM parameters that the IAM user needs to be able to read (e.g. ["/example/parameter1", "/example/config/*"]). | `list(string)` | `[]` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| access\_key | The IAM access key associated with the CI IAM user created by this module. |
| role | The IAM role that the CI user can assume to perform testing. |
| user | The CI IAM user created by this module. |
<!-- END_TF_DOCS -->

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
