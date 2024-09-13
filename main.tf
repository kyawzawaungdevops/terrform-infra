module "vpc" {
  source          = "./modules/vpc"
  env             = var.env
  name            = var.vpc-name
  az1             = var.az1
  az2             = var.az2
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
  cidr            = var.cidr
}

module "security-group" {
  source      = "./modules/security-group"
  vpc_id      = module.vpc.vpc_id
  cidr        = module.vpc.cidr
  env         = var.env
  app-sg-name = var.app-sg-name
  lb-sg-name  = var.lb-sg-name
}

module "launch_template" {
  source            = "./modules/launch-template"
  env               = var.env
  name              = var.launch_template-name
  security_group_id = module.security-group.security_group__id
  instance_type     = var.instance_type
  ec2_profile_name = var.ec2_profile_name
  ec2_iam_role = module.iam.iam_role_arn
}

module "aws_autoscaling_group" {
  source          = "./modules/asg"
  name            = var.asg-name
  env             = var.env
  private_subnets = module.vpc.private_subnet_ids
  launch_template = module.launch_template.launch_template__id
}

module "target-group" {
  source   = "./modules/target-group"
  asg-name = module.aws_autoscaling_group.asg-name
  vpc_id   = module.vpc.vpc_id
}


module "lb" {
  source            = "./modules/lb"
  public_subnets = module.vpc.public_subnet_ids
  security_group_id = module.security-group.security_group__id_lb
  target_group_arn  = module.target-group.target_group_arn
}


module "iam" {
 source            = "./modules/iam"
 iam_policy_name = var.iam_policy_name
}

