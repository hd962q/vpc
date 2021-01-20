resource "aws"
resource "aws_vpc" "vpc2" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc2"
  }
}
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.vpc2.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet2"
  }
}
resource "aws_internet_gateway" "gw2" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = "gw2"
  }
}
resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.vpc2.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.gw2.id
  }

  tags = {
    Name = "gw2"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt2.id
}
