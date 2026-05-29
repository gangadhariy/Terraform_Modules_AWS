// This is a complete AWS Terraform infrastructure setup
// designed for practicing production-like architecture deployment.

// Create Vpc
resource "aws_vpc" "atlas_core_vpc" {
    cidr_block = var.atlas_core_vpc_cidrblock
    tags = {
      Name = "atlas_prod_vpc"
    }
}

// Create Internet Gateway
resource "aws_internet_gateway" "atlas_core_internet_gateway" {
  vpc_id = aws_vpc.atlas_core_vpc.id
  tags = {
    Name = "atlas_prod_igw"
  }
}

// Create 2 Subnet
resource "aws_subnet" "atlas_core_subnet" {
  count = 2
  vpc_id = aws_vpc.atlas_core_vpc.id
  cidr_block = var.atlas_core_subnet_cidrblock[count.index]
  availability_zone = var.atlas_core_subnet_azs[count.index]
  # map_public_ip_on_launch = true
  tags = {
    Name = "atlas_prod_subnet_${count.index + 1}"
  }
}

// Create 2 Route Table
resource "aws_route_table" "atlas_core_rt" {
    count = 2
  vpc_id = aws_vpc.atlas_core_vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.atlas_core_internet_gateway.id
  }
  tags = {
    Name = "atlas_prod_public_route_${count.index + 1}"
  }
}

// Create routetable association
resource "aws_route_table_association" "atlas_core_rta" {
  count = 2
  subnet_id = aws_subnet.atlas_core_subnet[count.index].id
  route_table_id = aws_route_table.atlas_core_rt[count.index].id
}

// Create target group

resource "aws_lb_target_group" "atlas_core_target_group" {
  name = var.atlas_core_tg_name
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.atlas_core_vpc.id
  target_type = "instance"
  tags = {
    Name = "atlas_core_prod_tg"
  }
}

// Creating Security group to allow http and ssh

resource "aws_security_group" "atlas_core_sg" {
  name = var.atlas_core_sg_name
  vpc_id = aws_vpc.atlas_core_vpc.id
  description = "Allow http and ssh"
  dynamic "ingress" {
    for_each = var.atlas_core_sg_inbound_ports
    content {
        from_port = ingress.value.port
        to_port = ingress.value.port
        protocol = "tcp"
        cidr_blocks = ingress.value.cidr_block
        description = ingress.value.description
     }
   }
    egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

// Create aws load balancer
resource "aws_lb" "atlas_core_lb" {
  name               = var.atlas_core_lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.atlas_core_sg.id]
  subnets            = aws_subnet.atlas_core_subnet[*].id

  enable_deletion_protection = false

  access_logs {
    bucket  = "gng-lmd-test-bucket"
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "atlas"
  }
}

// Create Listner
resource "aws_lb_listener" "atlas_core_lb_listner" {
  load_balancer_arn = aws_lb.atlas_core_lb.arn
  port              = "80"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
 # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.atlas_core_target_group.arn
  }
}

// Create Launch Template

resource "aws_launch_template" "atlas_core_lt" {
  name = var.atlas_core_lt_name

  image_id = var.atlas_core_lt_ami_id

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t3.micro"

  key_name = "Devops-learn"

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true

    security_groups             = [aws_security_group.atlas_core_sg.id]
  }  

  # vpc_security_group_ids = [ aws_security_group.atlas_core_sg.id ]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "atlas-prod-lt"
    }
  }

  user_data = filebase64("${path.module}/asg.sh")
}

// Create Auto-Scaling group

resource "aws_autoscaling_group" "atlas_core_asg" {
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  vpc_zone_identifier       = aws_subnet.atlas_core_subnet[*].id  

  target_group_arns = [ aws_lb_target_group.atlas_core_target_group.arn ]

  launch_template {
    id      = aws_launch_template.atlas_core_lt.id
    version = "$Latest"
  }
}

