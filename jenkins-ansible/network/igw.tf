resource "aws_internet_gateway" "my-gw" {
  vpc_id = aws_vpc.sprints.id

}
