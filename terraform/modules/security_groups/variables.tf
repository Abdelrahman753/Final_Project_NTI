variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "env" {
  description = "Environment name"
  type        = string
}

variable "nlb_subnet_cidrs" {
  type = list(string)
}