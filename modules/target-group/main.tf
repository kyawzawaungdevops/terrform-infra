resource "aws_lb_target_group" "target-group" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}


resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = var.asg-name
  lb_target_group_arn    = aws_lb_target_group.target-group.arn
}