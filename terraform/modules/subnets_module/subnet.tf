resource "aws_subnet" "public_subnets" {
  vpc_id     = var.vpc_id
  cidr_block = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]
  count = length(var.public_subnets)

  tags = {  
        Name = "public-${var.env}-${count.index + 1}"
  }
}


resource "aws_subnet" "presentation_subnets" {
  vpc_id     = var.vpc_id
  cidr_block = var.presentation_subnets[count.index]
  availability_zone = var.azs[count.index]
  count = length(var.presentation_subnets)
  
  tags = {
        Name = "Presentation-${var.env}-${count.index + 1}"
  }
}

resource "aws_subnet" "database_subnets" {
  vpc_id     = var.vpc_id
  cidr_block = var.database_subnets[count.index]
  availability_zone = var.azs[count.index]
  count = length(var.database_subnets)

  tags = {
        Name = "database-${var.env}-${count.index + 1}"
  }
}

