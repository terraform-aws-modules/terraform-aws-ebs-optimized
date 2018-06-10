/**
# terraform-aws-ebs-optimized

* A terraform module to return true or false based on if an instance type
* supports the EBS optmized flag. If you want to use various instance types and
* EBS optimization, this module does the heavy lifting of determining if that's
* possible. Without the module, EC2 instance creation would fail on unsupported
* types and -- even worse -- launch configurations will create normally but fail
* silently when instances attempt to launch. This module means you don't need to
* think about that problem.

* ## Usage example

* A full example leveraging other community modules is contained in the [examples/ebs_optimized_test_fixture](https://github.com/terraform-aws-modules/terraform-aws-ebs-optimized/tree/master/examples/ebs_optimized_fixture). Here's the gist of using it via the Terraform registry:

* ```hcl
* variable "web_type" {
*   description = "Size/type of the host."
*   default     = "m1.large"
* }
*
* module "ebs_optimized" {
*   source        = "terraform-aws-modules/ebs-optimized/aws"
*   instance_type = "${var.web_type}"
* }
*
* resource "aws_instance" "web" {
*   ami           = "${data.aws_ami.ubuntu.id}"
*   instance_type = "${var.web_type}"
*   ebs_optimized = "${module.ebs_optimized.answer}"
* }
* ```

* ## Testing

* This module has been packaged with inspec tests through [kitchen](https://kitchen.ci/) and [kitchen-terraform](https://newcontext-oss.github.io/kitchen-terraform/). To run them:

* 1. Install [rvm](https://rvm.io/rvm/install) and the ruby version specified in the [Gemfile](https://github.com/terraform-aws-modules/terraform-aws-ebs-optimized/tree/master/Gemfile).
* 2. Install bundler and the gems from our Gemfile:
*
*     ```bash
*     gem install bundler && bundle install
*     ```
*
* 3. Test using `bundle exec kitchen test` from the root of the repo.

* inspec AWS resources are relatively new and not working on all platforms yet. If
* you're working with the module and tests are being skipped, ensure you verify functionality
* manually in the AWS console.

* ## Doc generation

* Documentation should be modified within `main.tf` and generated using [terraform-docs](https://github.com/segmentio/terraform-docs).
* Generate them like so:

* ```bash
* go get github.com/segmentio/terraform-docs
* terraform-docs md ./ | cat -s | ghead -n -1 > README.md
* ```

* ## Contributing

* Report issues/questions/feature requests on in the [issues](https://github.com/terraform-aws-modules/terraform-aws-ebs-optimized/issues/new) section.

* Full contributing [guidelines are covered here](https://github.com/terraform-aws-modules/terraform-aws-ebs-optimized/blob/master/CONTRIBUTING.md).

* ## Change log

* The [changelog](https://github.com/terraform-aws-modules/terraform-aws-ebs-optimized/tree/master/CHANGELOG.md) captures all important release notes.

* ## Authors

* Created and maintained by [Brandon O'Connor](https://github.com/brandoconnor) - brandon@atscale.run.
* Many thanks to [the contributors listed here](https://github.com/terraform-aws-modules/terraform-aws-ebs-optimized/graphs/contributors)!

* ## License

* MIT Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-ebs-optimized/tree/master/LICENSE) for full details.
*/

locals {
  ebs_optimized = {
    "c1.medium"    = false
    "c1.xlarge"    = true
    "c3.2xlarge"   = true
    "c3.4xlarge"   = true
    "c3.8xlarge"   = false
    "c3.large"     = false
    "c3.xlarge"    = false
    "c4.2xlarge"   = true
    "c4.4xlarge"   = true
    "c4.8xlarge"   = true
    "c4.large"     = true
    "c4.xlarge"    = true
    "c5.18xlarge"  = true
    "c5.2xlarge"   = true
    "c5.4xlarge"   = true
    "c5.9xlarge"   = true
    "c5.large"     = true
    "c5.xlarge"    = true
    "c5d.18xlarge" = true
    "c5d.2xlarge"  = true
    "c5d.4xlarge"  = true
    "c5d.9xlarge"  = true
    "c5d.large"    = true
    "c5d.xlarge"   = true
    "cc2.8xlarge"  = false
    "cr1.8xlarge"  = false
    "d2.2xlarge"   = true
    "d2.4xlarge"   = true
    "d2.8xlarge"   = true
    "d2.xlarge"    = true
    "f1.16xlarge"  = true
    "f1.2xlarge"   = true
    "g2.2xlarge"   = true
    "g2.8xlarge"   = false
    "g3.16xlarge"  = true
    "g3.4xlarge"   = true
    "g3.8xlarge"   = true
    "h1.16xlarge"  = true
    "h1.2xlarge"   = true
    "h1.4xlarge"   = true
    "h1.8xlarge"   = true
    "hs1.8xlarge"  = false
    "i2.2xlarge"   = true
    "i2.4xlarge"   = true
    "i2.8xlarge"   = false
    "i2.xlarge"    = true
    "i3.16xlarge"  = true
    "i3.2xlarge"   = true
    "i3.4xlarge"   = true
    "i3.8xlarge"   = true
    "i3.large"     = true
    "i3.metal"     = true
    "i3.xlarge"    = true
    "m1.large"     = true
    "m1.medium"    = false
    "m1.small"     = false
    "m1.xlarge"    = true
    "m2.2large"    = false
    "m2.2xlarge"   = true
    "m2.4xlarge"   = true
    "m2.xlarge"    = false
    "m3.2xlarge"   = true
    "m3.large"     = false
    "m3.medium"    = false
    "m3.xlarge"    = true
    "m4.10xlarge"  = true
    "m4.16xlarge"  = true
    "m4.2xlarge"   = true
    "m4.4xlarge"   = true
    "m4.large"     = true
    "m4.xlarge"    = true
    "m5.12xlarge"  = true
    "m5.24xlarge"  = true
    "m5.2xlarge"   = true
    "m5.4xlarge"   = true
    "m5.large"     = true
    "m5.xlarge"    = true
    "m5d.12xlarge" = true
    "m5d.24xlarge" = true
    "m5d.2xlarge"  = true
    "m5d.4xlarge"  = true
    "m5d.large"    = true
    "m5d.xlarge"   = true
    "p2.16xlarge"  = true
    "p2.8xlarge"   = true
    "p2.xlarge"    = true
    "p3.16xlarge"  = true
    "p3.2xlarge"   = true
    "p3.8xlarge"   = true
    "r3.2xlarge"   = false
    "r3.2xlarge"   = true
    "r3.4xlarge"   = true
    "r3.8xlarge"   = false
    "r3.large"     = false
    "r3.xlarge"    = true
    "r4.16xlarge"  = true
    "r4.2xlarge"   = true
    "r4.4xlarge"   = true
    "r4.8xlarge"   = true
    "r4.large"     = true
    "r4.xlarge"    = true
    "t1.micro"     = false
    "t2.2xlarge"   = false
    "t2.large"     = false
    "t2.medium"    = false
    "t2.micro"     = false
    "t2.nano"      = false
    "t2.small"     = false
    "t2.xlarge"    = false
    "x1.16xlarge"  = true
    "x1.32xlarge"  = true
    "x1e.16xlarge" = true
    "x1e.2xlarge"  = true
    "x1e.32xlarge" = true
    "x1e.4xlarge"  = true
    "x1e.8xlarge"  = true
    "x1e.xlarge"   = true
  }
}
