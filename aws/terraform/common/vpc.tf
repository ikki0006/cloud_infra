# Create a VPC
resource "aws_vpc" "my-vpc"{
  cidr_block = "${vpc_cidr}"
  tag {
    name = "${prefix}-vpc"
  }
}