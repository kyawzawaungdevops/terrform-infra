variable "env" {
  description = "environment name"
}

variable "name" {
  description = "lb name"
}


variable "launch_template" {
  type = string
  description = "launch template name"
}

variable "private_subnets" {
  type        = list(string)  
  description = "List of Private Subnets"
}
