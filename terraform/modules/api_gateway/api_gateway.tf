resource "aws_apigatewayv2_vpc_link" "vpc_link" {
  name               = var.vpc_link_name
  subnet_ids         = var.presentation_subnets_ids
  security_group_ids = [var.vpc_link_sg_id]
}

resource "aws_apigatewayv2_api" "api_gateway" {
  name          = var.api_name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "nlb" {
  api_id           = aws_apigatewayv2_api.api_gateway.id
  integration_type = "HTTP_PROXY"

  connection_type = "VPC_LINK"
  connection_id   = aws_apigatewayv2_vpc_link.vpc_link.id

  integration_uri = var.nlb_listener_arn

  integration_method = "ANY"
}



resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.api_gateway.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_route" "root" {
  api_id    = aws_apigatewayv2_api.api_gateway.id
  route_key = "ANY /"
  target    = "integrations/${aws_apigatewayv2_integration.nlb.id}"
}

resource "aws_apigatewayv2_route" "proxy" {
  api_id    = aws_apigatewayv2_api.api_gateway.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.nlb.id}"
}
