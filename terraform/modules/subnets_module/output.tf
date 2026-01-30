output "public_subnets_id" {
  value = aws_subnet.public_subnets[*].id
}

output "presentation_subnets_id" {
  value = aws_subnet.presentation_subnets[*].id
}

output "database_subnets_id" {
  value = aws_subnet.database_subnets[*].id
}