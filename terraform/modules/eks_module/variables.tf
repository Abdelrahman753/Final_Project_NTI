variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_cluster_version" {
  description = "Version of the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of nodes in the EKS node group"
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of nodes in the EKS node group"
  type        = number
}

variable "min_capacity" {
  description = "Minimum number of nodes in the EKS node group"
  type        = number
}
variable "instance_types" {
  description = "List of instance types for the EKS node group"
  type        = list(string)
}
variable "tags" {
  description = "Tags to be applied to EKS resources"
  type        = map(string)
}

variable "nodes_sg_id" {
  description = "The security group ID for EKS worker nodes"
  type        = string
}