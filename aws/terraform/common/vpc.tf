# Create a VPC
resource "aws_vpc" "${var.env}-vpc"{
  cidr_block = var.vpc_cidr
}