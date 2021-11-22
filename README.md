# terraform-aws-ebs-optimized

A terraform module to return true or false based on if an instance type
supports the EBS optmized flag. If you want to use various instance types and
EBS optimization, this module does the heavy lifting of determining if that's
possible. Without the module, EC2 instance creation would fail on unsupported
types and -- even worse -- launch configurations will create normally but fail
silently when instances attempt to launch. This module means you don't need to
think about that problem.

## Usage example

A full example leveraging other community modules is contained in the [examples/ebs_optimized_test_fixture](https://github.com/terraform-aws-modules/terraform-aws-ebs-optimized/tree/master/examples/ebs_optimized_fixture). Here's the gist of using it via the Terraform registry:

```hcl
variable "web_type" {
  description = "Size/type of the host."
  default     = "m1.large"
}

module "ebs_optimized" {
  source        = "terraform-aws-modules/ebs-optimized/aws"
  instance_type = "${var.web_type}"
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.web_type}"
  ebs_optimized = "${module.ebs_optimized.answer}"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| instance_type | Instance type to evaluate if EBS optimized is an option. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| answer | Returns 1 (true) or 0 (false) depending on if the instance type is able to be EBS optimized. |

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-key-pair/tree/master/LICENSE) for full details.
