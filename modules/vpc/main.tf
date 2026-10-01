resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
#==================================================
# Subnet
#=================================================
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "us-east-1a"
   tags = {
    Name = "Public-Subnet1"
   }
}
    resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.20.0/24"
  availability_zone = "us-east-1b"
   tags = {
    Name = "Public-Subnet2"
  }
}
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.30.0/24"
    availability_zone = "us-east-1a"
  tags = {
    Name = "Private-Subnet1"
  }
}
#===============================================
#IGW
#==============================================
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}
#==================================================
#EIP
#==================================================
resource "aws_eip" "nat_eip" {
  depends_on = [ aws_internet_gateway.gw ]
}
#==================================================
#NAT
#==================================================

resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "NAT"
  }
}

#==================================================
# Private Route Table
#==================================================
resource "aws_route_table" "Private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
   nat_gateway_id = aws_nat_gateway.NAT.id
  }
  tags = {
    Name = "Private-Route-Table"
  }
}

resource "aws_route_table_association" "Private_association" {
  subnet_id = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.Private_route_table.id
}
# ==========================================================
# Public Route Table
# ==========================================================
resource "aws_route_table" "Public_Route_Table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}
resource "aws_route_table_association" "Public_association" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.Public_Route_Table.id
}

resource "aws_route_table_association" "Public_association_2" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.Public_Route_Table.id
}