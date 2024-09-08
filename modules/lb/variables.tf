

variable "security_group_id" {
  type = string
  description = "sg group"
}

variable "target_group_arn" {
  type = string
  description = "target group"
}

variable "public_subnets" {
  type        = list(string)  # Changed to list to maintain the order
  description = "List of Private Subnets"
}