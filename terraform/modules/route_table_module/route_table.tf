resource "aws_route_table" "public_route_table" {
    vpc_id = var.vpc_id

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
    }

    
    tags = {
          Name = "public-rt-${var.env}"

    }
}

resource "aws_route_table_association" "public_route_table_association" {
  count = length(var.public_subnets_id)
  subnet_id = var.public_subnets_id[count.index]
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }

  tags = {
    Name = "private-rt-${var.env}"
  }
}

resource "aws_route_table_association" "presentation_route_table_association" {
  count = length(var.presentation_subnets_id)
  subnet_id = var.presentation_subnets_id[count.index]
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "database_route_table_association" {
  count = length(var.backend_subnets_id)
  subnet_id = var.backend_subnets_id[count.index]
  route_table_id = aws_route_table.private_route_table.id
}
    
