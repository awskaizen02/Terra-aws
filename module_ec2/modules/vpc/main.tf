# Create VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.vpc_name}_igw"
  }
}

# Create a Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}_public_subnet"
  }
}

# Create a Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "${var.vpc_name}_private_subnet"
  }
}

# Create a Route Table for Public Subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "${var.vpc_name}_public_rt"
  }
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Create a Route Table for Private Subnet (No Internet Access)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.vpc_name}_private_rt"
  }
}

# Associate Route Table with Private Subnet
resource "aws_route_table_association" "private_rt_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}
