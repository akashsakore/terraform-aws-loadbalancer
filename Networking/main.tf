variable "vpc_name" {}
variable "vpc_cidr_block" {}
variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}
variable "public_subnet_AZ" {}

output "my_vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.my_public_subnet.*.id
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "my_vpc"
  }
}

resource "aws_subnet" "my_public_subnet" {
  count = length(var.public_subnet_cidr)
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = element(var.public_subnet_cidr, count.index)
  availability_zone = element(var.public_subnet_AZ, count.index)
  tags = {
  Name = "my_public_subnet-${count.index + 1}"
  }
}


resource "aws_subnet" "my_private_subnet" {
  count = length(var.private_subnet_cidr)
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.public_subnet_AZ, count.index)
  tags = {
  Name = "my_private_subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
  Name = "my_igw"
  }
}

resource "aws_route_table" "my_public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id 
  }
  tags = {
    Name = "my_public_rt"
  }
}

resource "aws_route_table_association" "my_public_subnet_rt_association" {
  count = length(var.private_subnet_cidr)
  subnet_id      = aws_subnet.my_public_subnet[count.index].id
  route_table_id = aws_route_table.my_public_rt.id
}

resource "aws_route_table" "my_private_rt" {
  vpc_id = aws_vpc.my_vpc.id
    
  tags = {
    Name = "my_private_rt"
  }
}

resource "aws_route_table_association" "my_private_subnet_rt_association" {
  count = length(var.private_subnet_cidr)
  subnet_id      = aws_subnet.my_private_subnet[count.index].id
  route_table_id = aws_route_table.my_private_rt.id
}
