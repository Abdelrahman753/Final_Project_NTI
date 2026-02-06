variable "vpc_link_name" {
  description = "The name of the VPC link"
  type        = string
}


variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "nlb_dns" {
  description = "The DNS name of the NLB"
  type        = string
}

variable "listener_arn" {
  description = "The ARN of the NLB listener"
  type        = string
}


variable "presentation_subnets_ids" {
  description = "The IDs of the presentation subnets"
  type        = list(string)
}  

variable "vpc_link_sg_id" {
  description = "The ID of the VPC link security group"
  type        = string
}
variable "nlb_listener_arn" {
  description = "The ARN of the NLB listener"
  type        = string
}