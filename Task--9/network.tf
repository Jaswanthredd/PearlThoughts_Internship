# AWS Provider
provider "aws" {
  region = "us-east-1"
}

# VPC and Networking
resource "aws_vpc" "medusa_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "medusa-vpc"
  }
}

resource "aws_internet_gateway" "medusa_ig" {
  vpc_id = aws_vpc.medusa_vpc.id

  tags = {
    Name = "medusa-igw"
  }
}

resource "aws_subnet" "medusa_subnet" {
  vpc_id                  = aws_vpc.medusa_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "medusa-subnet"
  }
}

resource "aws_route_table" "medusa" {
  vpc_id = aws_vpc.medusa_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.medusa_ig.id
  }

  tags = {
    Name = "medusa"
  }
}

resource "aws_route_table_association" "medusa_rta" {
  subnet_id      = aws_subnet.medusa_subnet.id
  route_table_id = aws_route_table.medusa.id
}
