variable "public_subnets_id" {
  description = "Public subnet IDs"
  type        = list(string)
}
variable "env" {
  description = "Environment name"
  type        = string
}