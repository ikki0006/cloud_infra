# Create a VPC
resource "aws_vpc" "${var.prefix}Vpc" {
  cidr_block = "10.0.0.0/16"
}