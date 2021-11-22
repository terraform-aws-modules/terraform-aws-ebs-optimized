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
*/

locals {
  ebs_optimized = {
    "a1.xlarge"    = true
    "a1.2xlarge"   = true
    "a1.4xlarge"   = true
    "a1.large"     = true
    "a1.medium"    = true
    "c1.medium"    = false
    "c1.xlarge"    = true
    "c3.2xlarge"   = true
    "c3.4xlarge"   = true
    "c3.8xlarge"   = false
    "c3.large"     = false
    "c3.xlarge"    = true
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
    "c5n.18xlarge" = true
    "c5n.2xlarge"  = true
    "c5n.4xlarge"  = true
    "c5n.9xlarge"  = true
    "c5n.large"    = true
    "c5n.xlarge"   = true
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
    "g3s.xlarge"   = true
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
    "m5a.12xlarge" = true
    "m5a.24xlarge" = true
    "m5a.2xlarge"  = true
    "m5a.4xlarge"  = true
    "m5a.large"    = true
    "m5a.xlarge"   = true
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
    "r5a.12xlarge" = true
    "r5a.24xlarge" = true
    "r5a.2xlarge"  = true
    "r5a.4xlarge"  = true
    "r5a.large"    = true
    "r5a.xlarge"   = true
    "r5d.12xlarge" = true
    "r5d.24xlarge" = true
    "r5d.2xlarge"  = true
    "r5d.4xlarge"  = true
    "r5d.large"    = true
    "r5d.xlarge"   = true
    "r5.12xlarge"  = true
    "r5.24xlarge"  = true
    "r5.2xlarge"   = true
    "r5.4xlarge"   = true
    "r5.large"     = true
    "r5.xlarge"    = true
    "t1.micro"     = false
    "t2.2xlarge"   = false
    "t2.large"     = false
    "t2.medium"    = false
    "t2.micro"     = false
    "t2.nano"      = false
    "t2.small"     = false
    "t2.xlarge"    = false
    "t3.2xlarge"   = true
    "t3.large"     = true
    "t3.medium"    = true
    "t3.micro"     = true
    "t3.nano"      = true
    "t3.small"     = true
    "t3.xlarge"    = true
    "u-6tbl.metal" = true
    "u-9tbl.metal" = true
    "x1.16xlarge"  = true
    "x1.32xlarge"  = true
    "x1e.16xlarge" = true
    "x1e.2xlarge"  = true
    "x1e.32xlarge" = true
    "x1e.4xlarge"  = true
    "x1e.8xlarge"  = true
    "x1e.xlarge"   = true
    "z1d.12xlarge" = true
    "z1d.2xlarge"  = true
    "z1d.3xlarge"  = true
    "z1d.6xlarge"  = true
    "z1d.xlarge"   = true
    "z1d.large"    = true
  }
}
