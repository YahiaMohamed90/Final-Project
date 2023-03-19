resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.sprints.id
}


resource "aws_route" "public-route" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my-gw.id
}

resource "aws_route_table_association" "public-as1" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-as2" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-as3" {
  subnet_id      = aws_subnet.public-3.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-as4" {
  subnet_id      = aws_subnet.public-4.id
  route_table_id = aws_route_table.public-route-table.id
}




