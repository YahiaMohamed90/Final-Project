resource "aws_vpc" "sprints" {

  cidr_block = var.cidr
  enable_dns_hostnames = false

}
