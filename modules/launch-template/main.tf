locals {
  lt-name = "${var.env}-${var.name}"
}

resource "aws_iam_instance_profile" "this" {
name = var.ec2_profile_name
role = var.ec2_iam_role
}

# Launch Template Resource
resource "aws_launch_template" "app_server" {
  name = local.lt-name
  image_id = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  iam_instance_profile {
  name = aws_iam_instance_profile.this.name
  }
  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
            EOF
  )
  vpc_security_group_ids = [var.security_group_id] 
  update_default_version = true
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 10 
      delete_on_termination = true
      volume_type = "gp2" # default is gp2
     }
  }
  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "myasg"
    }
  }
}



