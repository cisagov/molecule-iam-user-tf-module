# Create an AWS IAM user capable of reading SSM Parameter Store parameters #

## Usage ##

To run this example you need to execute the `terraform init` command
followed by the `terraform apply` command.

Note that this example may create resources which cost money. Run
`terraform destroy` when you no longer need these resources.

## Outputs ##

| Name | Description |
|------|-------------|
| access_key | The IAM access key for the test-molecule-iam-user-tf-module user. |
| user | The test-molecule-iam-user-tf-module IAM user. |
