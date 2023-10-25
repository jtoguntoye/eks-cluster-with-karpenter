locals {
 public_subnet_tags = {
    "kubernetes.io/cluster/${var.EKSClusterName}" = "shared"
    "kubernetes.io/role/elb"              = 1
}

 private_subnet_tags = {
    "kubernetes.io/cluster/${var.EKSClusterName}" = "shared"
    "kubernetes.io/role/internal-elb"     = 1
    "karpenter.sh/discovery"              = var.EKSClusterName
}
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "${var.environment}-vpc"
  }
}

resource "aws_subnet" "pubsub1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = merge(local.public_subnet_tags,
  { Name   = "pubsub1-${var.environment}",
  })
}

resource "aws_subnet" "pubsub2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = merge(
    local.public_subnet_tags,
  { Name   = "pubsub2-${var.environment}",
  })
}

resource "aws_subnet" "privsub1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"

   tags = merge(
    local.private_subnet_tags,
  { Name   = "privsub1-${var.environment}",
  })
}

resource "aws_subnet" "privsub2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1d"

   tags = merge(
    local.private_subnet_tags,
  { Name   = "privsub2-${var.environment}",
  })
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pubsub1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.pubsub2.id
  route_table_id = aws_route_table.rt.id
}