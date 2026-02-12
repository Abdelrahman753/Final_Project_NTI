output "api_endpoint" {
  value = aws_apigatewayv2_api.api_gateway.api_endpoint
}
output "api_id" {
  value = aws_apigatewayv2_api.api_gateway.id
}

output "integration_id" {
  value = aws_apigatewayv2_integration.nlb.id
}
