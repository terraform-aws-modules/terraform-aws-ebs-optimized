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

## Testing

This module has been packaged with inspec tests through [kitchen](https://kitchen.ci/) and [kitchen-terraform](https://newcontext-oss.github.io/kitchen-terraform/). To run them:

1. Install [rvm](https://rvm.io/rvm/install) and the ruby version specified in the [Gemfile](https://github.com/terraform-aws-modules/terraform-aws-ebs-optimized/tree/master/Gemfile).
2. Install bundler and the gems from our Gemfile:

    ```bash
    gem install bundler && bundle install
    ```

3. Test using `bundle exec kitchen test` from the root of the repo.

inspec AWS resources are relatively new and not working on all platforms yet. If
you're working with the module and tests are being skipped, ensure you verify functionality
manually in the AWS console.

## Doc generation

Documentation should be modified within `main.tf` and generated using [terraform-docs](https://github.com/segmentio/terraform-docs).
Generate them like so:

```bash
go get github.com/segmentio/terraform-docs
terraform-docs md ./ | cat -s | ghead -n -1 > README.md
```

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/terraform-aws-modules/terraform-aws-ebs-optimized/issues/new) section.

Full contributing [guidelines are covered here](https://github.com/terraform-aws-modules/terraform-aws-ebs-optimized/blob/master/CONTRIBUTING.md).

## Change log

The [changelog](https://github.com/terraform-aws-modules/terraform-aws-ebs-optimized/tree/master/CHANGELOG.md) captures all important release notes.

## Authors

Created and maintained by [Brandon O'Connor](https://github.com/brandoconnor) - brandon@atscale.run.
Many thanks to [the contributors listed here](https://github.com/terraform-aws-modules/terraform-aws-ebs-optimized/graphs/contributors)!

## License

MIT Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-ebs-optimized/tree/master/LICENSE) for full details.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| instance_type | Instance type to evaluate if EBS optimized is an option. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| answer | Returns 1 (true) or 0 (false) depending on if the instance type is able to be EBS optimized. |
