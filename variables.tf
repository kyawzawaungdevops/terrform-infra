variable "vpc-name" {
  description = "vpc-name"
  default     = "dev-vpc"

}

variable "launch_template-name" {
  default = "dev-launch-template"
}

variable "env" {
  description = "environment name"
  default     = "dev-environment"
}

variable "az1" {
  type        = string
  description = "az1"
  default     = "us-east-1a"
}

variable "az2" {
  type        = string
  description = "az2"
  default     = "us-east-1b"
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "lb-sg-name" {
  default     = "lb-sg-name"
  description = "lb"
}

variable "app-sg-name" {
  default     = "app-sg-name"
  description = "app"
}

variable "asg-name" {
  default = "dev-asg"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "private_subnets" {
  type        = list(string) 
  description = "List of Private Subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  type        = list(string) 
  description = "List of Private Subnets"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "iam_policy_name" {
  type = string
  default = "instanceiamrolename"
}

variable "ec2_profile_name" {
  type = string
  default = "instanceprofiletest"
}