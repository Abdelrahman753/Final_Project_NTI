output "nlb_arn" {
  value = aws_lb.nlb.arn
}

output "dns_name" {
  value = aws_lb.nlb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.nlb_target_group.arn
}

output "listener_arn" {
  value = aws_lb_listener.nlb_listener.arn
}
