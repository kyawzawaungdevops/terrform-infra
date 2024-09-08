locals {
  app-sg-name = "${var.env}-${var.app-sg-name}"
  lb-sg-name = "${var.env}-${var.lb-sg-name}"
}

resource "aws_security_group" "appsg" {
  name        = local.app-sg-name
  description = "security group of ec2 instances"
  vpc_id      = var.vpc_id

  tags = {
  
    Name = local.app-sg-name
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.appsg.id
  cidr_ipv4         = var.cidr
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.appsg.id
  cidr_ipv4         = var.cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_security_group_rule" "allow_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.appsg.id
}



resource "aws_security_group" "lbsg" {
  name        = local.lb-sg-name
  description = "security group of load balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = local.lb-sg-name
    }
}

resource "aws_security_group_rule" "allow_egress_all_lb" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lbsg.id
}


resource "aws_vpc_security_group_ingress_rule" "allow_all" {
  security_group_id = aws_security_group.lbsg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}