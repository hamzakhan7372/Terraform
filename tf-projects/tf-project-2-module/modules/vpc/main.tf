resource "aws_vpc" "tf_practice_vpc" {
  cidr_block = "172.50.0.0/16"
  tags = {
    Project = "Terraform-vpc"
  }

}
##Public subnet
resource "aws_subnet" "tf_pub_subnet_1" {
  vpc_id                  = aws_vpc.tf_practice_vpc.id
  cidr_block              = "172.50.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.az-1

  tags = {
    Name = "Public_Subnet_1"
  }
}

resource "aws_subnet" "tf_pub_subnet_2" {
  vpc_id                  = aws_vpc.tf_practice_vpc.id
  cidr_block              = "172.50.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.az-2

  tags = {
    Name = "Public_Subnet_2"
  }
}

resource "aws_subnet" "tf_pub_subnet_3" {
  vpc_id                  = aws_vpc.tf_practice_vpc.id
  cidr_block              = "172.50.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.az-3

  tags = {
    Name = "Public_Subnet_3"
  }
}

##Private subnet
resource "aws_subnet" "tf_private_subnet_1" {
  vpc_id            = aws_vpc.tf_practice_vpc.id
  cidr_block        = "172.50.4.0/24"
  availability_zone = var.az-1

  tags = {
    Name = "Private_Subnet_1"
  }
}

resource "aws_subnet" "tf_private_subnet_2" {
  vpc_id                  = aws_vpc.tf_practice_vpc.id
  cidr_block              = "172.50.5.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.az-2

  tags = {
    Name = "Private_Subnet_2"
  }
}

resource "aws_subnet" "tf_private_subnet_3" {
  vpc_id                  = aws_vpc.tf_practice_vpc.id
  cidr_block              = "172.50.6.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.az-3

  tags = {
    Name = "Private_Subnet_3"
  }
}

#Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tf_practice_vpc.id
  tags = {
    Name = "tf-igw"
  }
}


#Public Route table
resource "aws_route_table" "tf-public-rt" {
  vpc_id = aws_vpc.tf_practice_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "tf_public_route_table"
  }

}

#subnet association
resource "aws_route_table_association" "tf-public-rt_association-1" {
  subnet_id      = aws_subnet.tf_pub_subnet_1.id
  route_table_id = aws_route_table.tf-public-rt.id

}

resource "aws_route_table_association" "tf-public-rt_association-2" {
  subnet_id      = aws_subnet.tf_pub_subnet_2.id
  route_table_id = aws_route_table.tf-public-rt.id

}

resource "aws_route_table_association" "tf-public-rt_association-3" {
  subnet_id      = aws_subnet.tf_pub_subnet_3.id
  route_table_id = aws_route_table.tf-public-rt.id

}

#Private Route table
resource "aws_route_table" "tf-private-rt" {
  vpc_id = aws_vpc.tf_practice_vpc.id

  tags = {
    Name = "tf_private_route_table"
  }

}

#subnet association
resource "aws_route_table_association" "tf-private-rt_association-1" {
  subnet_id      = aws_subnet.tf_private_subnet_1.id
  route_table_id = aws_route_table.tf-private-rt.id

}

resource "aws_route_table_association" "tf-private-rt_association-2" {
  subnet_id      = aws_subnet.tf_private_subnet_2.id
  route_table_id = aws_route_table.tf-private-rt.id

}

resource "aws_route_table_association" "tf-private-rt_association-3" {
  subnet_id      = aws_subnet.tf_private_subnet_3.id
  route_table_id = aws_route_table.tf-private-rt.id

}

## END OF VPC

## Creating a security group in that VPC

resource "aws_security_group" "tf-security-group-1" {
  name        = "allow all trafic"
  description = "allow all trafic"
  vpc_id      = aws_vpc.tf_practice_vpc.id

  # 0, in port rule means fromm every port
  # "-1", allowing allwoing all protocols
  # ["0.0.0.0/0"], Parameters means which allows traffic from any IP address.
  ingress {
    from_port        = 0
    protocol         = "-1"
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  egress {
    from_port        = 0
    protocol         = "-1"
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name" = "tf-security-group"
  }

}

data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "foo" {
  name = "Default-security-group"
}


