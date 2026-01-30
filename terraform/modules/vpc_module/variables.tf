variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "nonprod"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}