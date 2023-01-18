resource "aws_instance" "tf-ec2-public" {
  ami           = var.ami_ubuntu_id
  instance_type = "t2.micro"

  tags = {
    Name = "tf-ec2-public"
  }
}

resource "aws_instance" "tf-ec2-private" {
  ami           = var.ami_ubuntu_id
  instance_type = "t2.micro"

  tags = {
    Name = "tf-ec2-private"
  }
}

resource "aws_vpc" "tf-vpc" {
  cidr_block       = "10.0.0.0/16"
  tags = {
    Name = "tf-vpc"
  }
}

resource "aws_subnet" "subnet-public" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet-public"
    }
}
resource "aws_subnet" "subnet-private" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "subnet-private"
    }
}

resource "aws_route_table" "route-table-public" {
  vpc_id = aws_vpc.tf-vpc.id

  route = []

  tags = {
    Name = "route-table-public"
  }
}

resource "aws_route_table" "route-table-private" {
  vpc_id = aws_vpc.tf-vpc.id

  route = []

  tags = {
    Name = "route-table-private"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "application-gateway"
  }
}
