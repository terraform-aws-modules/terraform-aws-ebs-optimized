locals {
  tags = "${map("Environment", "test",
                "GithubRepo", "terraform-aws-ebs-optimized",
                "GithubOrg", "terraform-aws-modules",
                "Workspace", "${terraform.workspace}",
  )}"
}

provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "ebs_optimized" {
  name_prefix   = "test_ebs_optimized"
  image_id      = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.supported_type}"
  ebs_optimized = "${module.supported_ebs.answer}"
}

resource "aws_launch_configuration" "ebs_not_optimized" {
  name_prefix   = "test_ebs_not_optimized"
  image_id      = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.unsupported_type}"

  ebs_optimized = "${module.unsupported_ebs.answer}"
}

resource "aws_instance" "ebs_optimized" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.supported_type}"
  ebs_optimized = "${module.supported_ebs.answer}"
  tags          = "${merge(local.tags, map("Name", "test_ebs_optimized"))}"
}

resource "aws_instance" "ebs_not_optimized" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.unsupported_type}"
  ebs_optimized = "${module.unsupported_ebs.answer}"
  tags          = "${merge(local.tags, map("Name", "test_not_ebs_optimized"))}"
}

module "supported_ebs" {
  source        = "../.."
  instance_type = "${var.supported_type}"
}

module "unsupported_ebs" {
  source        = "../.."
  instance_type = "${var.unsupported_type}"
}

module "unknown_type" {
  source        = "../.."
  instance_type = "z1.whatever"
}
