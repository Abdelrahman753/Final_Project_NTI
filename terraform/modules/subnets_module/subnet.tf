resource "aws_subnet" "public_subnets" {
  vpc_id     = var.vpc_id
  cidr_block = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]
  count = length(var.public_subnets)

  tags = {  
        Name = "public-${var.env}-${count.index + 1}"
  }
}


resource "aws_subnet" "private_subnets" {
  vpc_id     = var.vpc_id
  cidr_block = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]
  count = length(var.private_subnets)

  tags = {
        Name = "private-${var.env}-${count.index + 1}"
  }
}