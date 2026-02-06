resource "aws_security_group" "vpc_link_sg" {
  name        = "${var.env}-apigw-vpclink-sg"
  description = "API Gateway VPC Link SG"
  vpc_id      = var.vpc_id


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}


resource "aws_security_group" "nodes_sg" {
  name        = "${var.env}-eks-nodes-sg"
  description = "EKS worker nodes SG"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
resource "aws_security_group_rule" "nodes_self_all" {
  type              = "ingress"
  security_group_id = aws_security_group.nodes_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
}



resource "aws_security_group_rule" "nlb_to_nodes_80" {
  for_each          = toset(var.nlb_subnet_cidrs)
  type              = "ingress"
  security_group_id = aws_security_group.nodes_sg.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = [each.value]
}

resource "aws_security_group_rule" "nlb_to_nodes_443" {
  for_each          = toset(var.nlb_subnet_cidrs)
  type              = "ingress"
  security_group_id = aws_security_group.nodes_sg.id

  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = [each.value]
}


resource "aws_security_group_rule" "vpclink_to_nodes_80" {
  type                     = "ingress"
  security_group_id        = aws_security_group.nodes_sg.id
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.vpc_link_sg.id
}

resource "aws_security_group_rule" "vpclink_to_nodes_443" {
  type                     = "ingress"
  security_group_id        = aws_security_group.nodes_sg.id
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.vpc_link_sg.id
}


