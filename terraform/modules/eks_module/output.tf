output "eks_cluster_id" {
  value = aws_eks_cluster.eks_cluster.id
}
output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.eks_cluster.arn
}
output "alb_controller_irsa_role_arn" {
  value = aws_iam_role.aws_load_balancer_controller.arn
}