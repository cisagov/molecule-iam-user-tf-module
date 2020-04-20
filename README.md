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

  aws_region = "us-east-2"

  ssm_parameters = ["/example/parameter1", "/example/config/*"]
  user_name      = "test-molecule-iam-user-tf-module"

  tags = {
    Team        = "VM Fusion - Development"
    Application = "molecule-iam-user-tf-module testing"
  }
}
```

## Examples ##

* [Create an AWS IAM user capable of reading SSM Parameter Store parameters](https://github.com/cisagov/molecule-iam-user-tf-module/tree/develop/examples/basic_usage)

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| aws_region | The region to use for all AWS resources created. | string | `us-east-1` | no |
| ssm_parameters | The AWS SSM parameters that the IAM user needs to be able to read (e.g. ["/example/parameter1", "/example/config/*"]). | list(string) | | yes |
| user_name | The name to associate with the AWS IAM user (e.g. test-molecule-iam-user-tf-module) | string | | yes |
| tags | Tags to apply to all AWS resources created | map(string) | `{}` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| access_key | The IAM access key associated with the IAM user created by this module. |
| user | The IAM user created by this module. |

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
