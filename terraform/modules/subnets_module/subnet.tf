resource "aws_subnet" "public_subnets" {
  vpc_id     = var.vpc_id
  cidr_block = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]
  count = length(var.public_subnets)
  map_public_ip_on_launch = true

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

resource "aws_subnet" "backend_subnets" {
  vpc_id     = var.vpc_id
  cidr_block = var.backend_subnets[count.index]
  availability_zone = var.azs[count.index]
  count = length(var.backend_subnets)

  tags = {
        Name = "backend-${var.env}-${count.index + 1}"
  }
}

