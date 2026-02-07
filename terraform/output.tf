output "eks_cluster_name" {
  value = module.eks_module.cluster_name
}

output "nlb_target_group_arn" {
  value = module.nlb.target_group_arn
}

output "api_endpoint" {
  value = try(module.apigw.api_endpoint, null)
}