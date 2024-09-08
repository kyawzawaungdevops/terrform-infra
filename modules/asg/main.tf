locals {
  asgname = "${var.env}-${var.name}"
}


resource "aws_autoscaling_group" "asg" {
  name     = local.asgname
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 4
  vpc_zone_identifier       =  var.private_subnets
    launch_template {
    id      = var.launch_template
  }
}