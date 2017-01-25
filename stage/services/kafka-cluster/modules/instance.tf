#---------------------------------------------------------------
#This module create all resource needed for create a kafka host
#---------------------------------------------------------------

#Variables
variable "name"              { default = "kafka" }
variable "vpc_id"            { }
variable "ami_id"            { }
variable "vpc_cidr"          { }
variable "region"            { }
variable "public_subnet_id"  { }
variable "key_name"          { }
variable "instance_type"     { }

#Create security group
resource "aws_security_group" "kafka" {
  name        = "${var.name}"
  vpc_id      = "${var.vpc_id}"
  description = "Kafka security group"

  tags      { Name = "${var.name}" }
  lifecycle { create_before_destroy = true }

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol = "tcp"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress{
    protocol = -1
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Create instance
resource "aws_instance" "kafka" {
  instance_type = "${var.instance_type}"
  ami           = "${var.ami_id}"
  subnet_id     = "${var.public_subnet_id}"
  key_name      = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.kafka.id}"]
  associate_public_ip_address = true

  tags      { Name = "${var.name}" }
  lifecycle { create_before_destroy = true }
}

#Output
output "user"       { value = "ubuntu" }
output "private_ip" { value = "${aws_instance.kafka.private_ip}" }
output "public_ip"  { value = "${aws_instance.kafka.public_ip}" }
output "public_dns" { value = "${aws_instance.kafka.public_dns}" }

