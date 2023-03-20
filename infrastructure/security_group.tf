
resource "aws_security_group" "server" {
  name   = "server_access"
  vpc_id = local.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_key_pair" "deployer" {
  key_name   = "my-key"
  public_key = file(local.public_key_path)
}

