variable "env" {
  description = "environment name"
}

variable "name" {
  description = "vpc name"
}


variable "security_group_id" {
  type = string
  description = "sg group"
}

variable "instance_type" {
  type = string
  description = "instance type"
}

variable "ec2_profile_name" {
  type = string
  description = "name of ec2 instance iam profile"

}

variable "ec2_iam_role" {
  type = string
  description = "ec2 iam role"
}
