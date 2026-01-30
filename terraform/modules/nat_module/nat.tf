resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "nat-eip-${var.env}"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnets_id[0]
  tags = {
    Name = "nat-gateway-${var.env}"
  }
}