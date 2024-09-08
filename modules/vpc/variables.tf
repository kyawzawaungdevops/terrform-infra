variable "env" {
  description = "environment name"
}

variable "name" {
  description = "vpc name"
}

variable "cidr" {
  description = "cidr block for vpc"
}

variable "az1" {
  description = "Availability Zone"
}

variable "az2" {
  description = "Availability Zone"
}

variable "private_subnets" {
  type        = list(string)  # Changed to list to maintain the order
  description = "List of Private Subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of Availability Zones for Private Subnets"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets" {
  type        = list(string)  # Changed to list to maintain the order
  description = "List of Private Subnets"
}