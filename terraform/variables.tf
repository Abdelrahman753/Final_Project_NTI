variable "region" {
  description = "AWS region"
  type        = string
}



variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}


variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "presentation_subnets" {
  description = "Presentation subnet CIDRs"
  type        = list(string)
}

variable "backend_subnets" {
  description = "Database subnet CIDRs"
  type        = list(string)
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_cluster_version" {
  description = "Version of the EKS cluster"
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


variable "nlb_name" {
  description = "nlb name"
}



variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "listener_port" {
  description = "Port for the NLB listener"
  type        = number
}

variable "vpc_link_name" {
  description = "Name of the VPC link"
  type        = string
}
variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
}