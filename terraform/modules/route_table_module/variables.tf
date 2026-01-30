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

