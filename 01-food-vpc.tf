# VPC
resource "aws_vpc" "food-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "food-vpc"
  }
}

# IGW
resource "aws_internet_gateway" "food-igw" {
  vpc_id = aws_vpc.food-vpc.id

  tags = {
    Name = "food-igw"
  }
}

# Route Table-pub
resource "aws_route_table" "food-rtb-pub" {
  vpc_id = aws_vpc.food-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.food-igw.id
  }

  tags = {
    Name = "food-pub-rtb"
  }
}

# Route Table-pri
resource "aws_route_table" "food-rtb-pri" {
  vpc_id = aws_vpc.food-vpc.id

  tags = {
    Name = "food-pri-rtb"
  }
}

# Subnet-pub
resource "aws_subnet" "food-sb-pub" {
  vpc_id     = aws_vpc.food-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "food-pub-sb"
  }
}

# Subnet-pri
resource "aws_subnet" "food-sb-pri" {
  vpc_id     = aws_vpc.food-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "food-pri-sb"
  }
}

# Subnet-RTB ASSOSIATION
# Public
resource "aws_route_table_association" "food-pub-rtb-sb" {
  subnet_id      = aws_subnet.food-sb-pub.id
  route_table_id = aws_route_table.food-rtb-pub.id
}

# Private
resource "aws_route_table_association" "food-pri-rtb-sb" {
  subnet_id      = aws_subnet.food-sb-pri.id
  route_table_id = aws_route_table.food-rtb-pri.id
}
