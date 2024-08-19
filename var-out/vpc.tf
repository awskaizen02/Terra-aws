provider "aws" {
  region = var.region
}

resource "aws_vpc" "demo" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "demo-vpc"
  }
}

resource "aws_subnet" "demo" {
  count = length(var.subnet_cidrs)

  vpc_id            = aws_vpc.demo.id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "demo-subnet-${count.index + 1}"
  }
}

data "aws_availability_zones" "available" {}