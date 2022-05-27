# VPC
resource "aws_vpc" "vpc_test" {
  cidr_block = var.cidr_vpc
}

# 2 private subnet 

resource "aws_subnet" "private_subnet" {
  count             = var.subnet_number
  vpc_id            = aws_vpc.vpc_test.id
  cidr_block        = var.cidr_private_subnet[count.index]
  availability_zone = var.az

  tags = {
    Name = "Private subnet-${count.index}"
  }
}

# 2 public subnet

resource "aws_subnet" "public_subnet" {
  count             = var.subnet_number
  vpc_id            = aws_vpc.vpc_test.id
  cidr_block        = var.cidr_public_subnet[count.index]
  availability_zone = var.az

  tags = {
    Name = "public subnet-${count.index}"
  }
}

#IGW
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc_test.id

  tags = {
    Name = "gateway test"
  }
}

# EIP for NAT gateway
resource "aws_eip" "eip_nat" {
  vpc = true
}

# NAT gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "gateway NAT"
  }

  depends_on = [aws_internet_gateway.gateway]
}

# public route table

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc_test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "Public route table"
  }
}

# association route-subnet
resource "aws_route_table_association" "public" {
  count          = var.subnet_number
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route.id
}

# private route table
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc_test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "Private route table"
  }
}

#association
resource "aws_route_table_association" "private" {
  count          = var.subnet_number
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route.id
}



