
resource "aws_subnet" "public-1" {
  vpc_id                  = aws_vpc.sprints.id
  cidr_block              = var.public-subnet1
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-2b"

}

resource "aws_subnet" "public-2" {
  vpc_id                  = aws_vpc.sprints.id
  cidr_block              = var.public-subnet2
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-2c"

}

resource "aws_subnet" "public-3" {
  vpc_id                  = aws_vpc.sprints.id
  cidr_block              = var.public-subnet3
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-2d"

}

resource "aws_subnet" "public-4" {
  vpc_id                  = aws_vpc.sprints.id
  cidr_block              = var.public-subnet4
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-2a"

}

