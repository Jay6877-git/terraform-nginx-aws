locals {
  common_tags = {
    ManagedBy = "Terraform"
    Project   = "Terraform-NGINX-AWS"
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = merge(local.common_tags, {
    Name = "NGINX-Server-VPC"
  })
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"

  tags = merge(local.common_tags, {
    Name = "NGINX-Server-Public-Subnet"
  })
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.common_tags, {
    Name = "NGINX-Server-IGW"
  })
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = merge(local.common_tags, {
    Name = "NGINX-Server-RTB"
  })
}

resource "aws_route_table_association" "public_rtb" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rtb.id
}