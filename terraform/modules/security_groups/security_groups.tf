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





