resource "aws_vpc" "vpc-test" {
  cidr_block = var.cidr_vpc
}

resource "aws_subnet" "subnet-privata" {
  count      = var.numero_subnet
  vpc_id     = aws_vpc.vpc-test.id
  cidr_block = var.cidr_subnet_privata[count.index]
  
  tags = {
    Name = "subnet privata-${count.index}"
  }
}

resource "aws_subnet" "subnet-pubblica" {
  count      = var.numero_subnet 
  vpc_id     = aws_vpc.vpc-test.id
  cidr_block = var.cidr_subnet_pubblica[count.index]
  
  tags = {
    Name = "subnet pubblica-${count.index}"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc-test.id

  tags = {
    Name = "gateway test"
  }
}

resource "aws_eip" "eip-nat" {
    vpc   = true
}

resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.eip-nat.id
  subnet_id     = aws_subnet.subnet-pubblica[0].id

  tags = {
    Name = "gateway NAT"
  }

  depends_on = [aws_internet_gateway.gateway]
}

resource "aws_route_table" "route-pubblica" {
  vpc_id = aws_vpc.vpc-test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "Route table pubblica"
  }
}

resource "aws_route_table_association" "pubblica" {
  count          = var.numero_subnet
  subnet_id      = aws_subnet.subnet-pubblica[count.index].id
  route_table_id = aws_route_table.route-pubblica.id
}

resource "aws_route_table" "route-privata" {
  vpc_id = aws_vpc.vpc-test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.NAT.id
  }

  tags = {
    Name = "Route table privata"
  }
}

resource "aws_route_table_association" "privata" {
  count          = var.numero_subnet
  subnet_id      = aws_subnet.subnet-privata[count.index].id
  route_table_id = aws_route_table.route-privata.id
}



