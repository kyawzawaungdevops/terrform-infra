resource "aws_lb" "test" {
  name               = "test-lb2"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            =  var.public_subnets
  enable_deletion_protection = false
  tags = {
    Environment = "production"
  }
}


resource "aws_lb_listener" "my_alb_listener" {
 load_balancer_arn = aws_lb.test.arn
 port              = "80"
 protocol          = "HTTP"

 default_action {
   type             = "forward"
   target_group_arn = var.target_group_arn
 }
}

