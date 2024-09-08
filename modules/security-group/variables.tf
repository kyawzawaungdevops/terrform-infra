variable "vpc_id" {
  description = "vpc id"
}

variable "env" {
  description = "environment name"
}

variable "app-sg-name" {
  description  = "security-group-name"
}


variable "lb-sg-name" {
  description  = "security-group-name"
}

variable "cidr" {
  default = "allowed cidr for security group"
}