#===============================================================================
# Create lab infra
#===============================================================================

# Configure the AWS Provider
provider "aws" {
  version = "~> 2.0"
  region  = "${var.awsCreds.data["region"]}"
  access_key = "${var.awsCreds.data["access_key"]}"
  secret_key = "${var.awsCreds.data["secret_key"]}"
}


# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.prefix}example-vpc"
  }
}


output "creds" {
  value = "${var.awsCreds}"
}
