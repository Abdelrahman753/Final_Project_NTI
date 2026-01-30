variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "gateway_id" {
  description = "ID of the internet gateway"
  type        = string
}



variable "env" {
  description = "Environment name"
  type        = string
}

variable "public_subnets_id" {
  description = "ID of the public subnet"
  type        = list(string) 
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "nat_id" {
  description = "ID of the NAT gateway"
  type        = string
}

variable "presentation_subnets_id" {
  description = "ID of the presentation subnet"
  type        = list(string)
}

variable "backend_subnets_id" {
  description = "ID of the database subnet"
  type        = list(string)
}