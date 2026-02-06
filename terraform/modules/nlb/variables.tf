variable "nlb_name" {
  description = "The name of the NLB"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs for the NLB"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the NLB"
  type        = map(string)
}

variable "listener_port" {
  description = "The port for the NLB listener"
  type        = number
}

variable "target_group_arn" {
  description = "The ARN of the target group"
  type        = string
}


variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "The port of the target group"
  type        = number
}

variable "vpc_id" {
  description = "The VPC ID for the target group"
  type        = string
}
