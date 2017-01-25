#--------------------------------------------------------------
# This module creates all kafka resources
#--------------------------------------------------------------

#Provider resource
provider "aws"{
  region = "${var.region}"
}

module "kafka" {
  source = "./modules"

  name              = "${var.name}-kafka"
  vpc_id            = "${var.vpc_id}"
  vpc_cidr          = "${var.vpc_cidr}"
  region            = "${var.region}"
  public_subnet_id  = "${var.public_subnet_id}"
  key_name          = "${var.key_name}"
  instance_type     = "${var.kafka_instance_type}"
  ami_id            = "${var.ami_id}"
}
