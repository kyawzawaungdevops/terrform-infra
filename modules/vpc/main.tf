locals {
  name = "${var.env}-${var.name}"
}

resource "aws_vpc" "this" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = local.name
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets)

  vpc_id     = aws_vpc.this.id
  cidr_block = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets)

  vpc_id     = aws_vpc.this.id
  cidr_block = var.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}



resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "ingw"
  }
}

resource "aws_nat_gateway" "nat-1" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnets[1].id
  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip" "eip" {
depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-1.id
  }

  tags = {
    Name = "private-rtb"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rtb"
  }
}

resource "aws_route_table_association" "private_subnet_associations" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private-route-table.id
}


resource "aws_route_table_association" "public_subnet_associations" {
  count = length(var.public_subnets)

  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public-route-table.id
}
