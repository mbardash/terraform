#--------------------------------------------------------------
# This module creates all networking resources
#--------------------------------------------------------------

#AWS Credentials and region
provider "aws" {
#	access_key = "${var.aws_access_key}"
#	secret_key = "${var.aws_secret_key}"
    profile                  = "default"
    region                   = "${var.region}"
}

module "vpc" {
  source = "./vpc"

  name = "${var.name}-vpc"
  cidr = "${var.vpc_cidr}"
}

module "public_subnet" {
  source = "./public_subnet"

  name   = "${var.name}-public"
  vpc_id = "${module.vpc.vpc_id}"
  cidrs  = "${var.public_subnets}"
  azs    = "${var.azs}"
  
}

module "bastion" {
  source = "./bastion"

  name              = "${var.name}-bastion"
  vpc_id            = "${module.vpc.vpc_id}"
  vpc_cidr          = "${module.vpc.vpc_cidr}"
  region            = "${var.region}"
  public_subnet_ids = "${module.public_subnet.subnet_ids}"
  key_name          = "${var.key_name}"
  instance_type     = "${var.bastion_instance_type}"
}

module "nat" {
  source = "./nat"

  name              = "${var.name}-nat"
  azs               = "${var.azs}"
  public_subnet_ids = "${module.public_subnet.subnet_ids}"
}

module "private_subnet" {
  source = "./private_subnet"

  name   = "${var.name}-private"
  vpc_id = "${module.vpc.vpc_id}"
  cidrs  = "${var.private_subnets}"
  azs    = "${var.azs}"

  nat_gateway_ids = "${module.nat.nat_gateway_ids}"
}

# VPC
output "vpc_id"   { value = "${module.vpc.vpc_id}" }
output "vpc_cidr" { value = "${module.vpc.vpc_cidr}" }

# Subnets
output "public_subnet_ids"  { value = "${module.public_subnet.subnet_ids}" }
output "private_subnet_ids" { value = "${module.private_subnet.subnet_ids}" }

# Bastion
output "bastion_user"       { value = "${module.bastion.user}" }
output "bastion_private_ip" { value = "${module.bastion.private_ip}" }
output "bastion_public_ip"  { value = "${module.bastion.public_ip}" }

# NAT
output "nat_gateway_ids" { value = "${module.nat.nat_gateway_ids}" }
