#AWS Credentials and region
provider "aws" {
	access_key = "AKIAIEA4JL6DUBDFMUIQ"
	secret_key = "x730qwhWcDFZJTLnXNi6IucAWEufP+Z2NrtjBTqC"
	region = "us-east-1"
}

resource "aws_launch_configuration" "example" {
  image_id               = "ami-40d28157"
  instance_type          = "t2.micro"
  security_groups        = ["${aws_security_group.instance.id}"]
  key_name               = "Sysadmin"

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example"{
    launch_configuration = "${aws_launch_configuration.example.id}"
    availability_zones        = ["us-east-1a"]
    vpc_zone_identifier       = ["subnet-44c2e50d"]

    load_balancers = ["${aws_elb.example.name}"]
    health_check_type = "ELB"

    min_size  = 2
    max_size  = 10

    tag {
      key                 = "Name"
      value               = "terraform-asg-example"
      propagate_at_launch = true
    }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_availability_zones" "all" {}


resource "aws_elb" "example"{
  name = "terraform-asg-example"
  security_groups     = ["${aws_security_group.elb.id}"]
  subnets             = ["subnet-44c2e50d"]

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "${var.server_port}"
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:${var.server_port}/"
  }
}

resource "aws_security_group" "elb" {
  name    = "terraform-example-elb"
  vpc_id  = "${var.vpc_id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



