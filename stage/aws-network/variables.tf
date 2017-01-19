#variable "aws_access_key" {}
#variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

variable "region" {
    default = "us-east-1"
}
variable "name"            {
	default = "vpc"
}
variable "vpc_cidr"        { 
	default = "10.0.0.0/16"
}
variable "azs"             {
    default = "us-east-1a,us-east-1b,us-east-1d"
}

variable "public_subnets"  {
    default = "10.0.1.0/24,10.0.2.0/24,10.0.3.0/24"
}

variable "private_subnets" {
    default = "10.0.100.0/24,10.0.101.0/24,10.0.103.0/24"
}

variable "key_name"        { 
	default = "gaea"
}

variable "bastion_instance_type" { 
	default = "m1.small"
}
