output "eks_cluster_name" {
  value = module.eks_module.eks_cluster_name
}

output "nlb_target_group_arn" {
  value = module.nlb_module.target_group_arn
}

output "api_endpoint" {
  value = module.api_gateway_module.api_endpoint
}

output "alb_controller_irsa_role_arn" {
  value = module.eks_module.alb_controller_irsa_role_arn
}