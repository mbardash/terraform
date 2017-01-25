variable "region"                 {
    default = "us-east-1"
}

variable "kafka_instance_type"  {
	default = "t2.micro"
}

variable "key_name"               {
	default = "gaea"
}

variable "name"                   {
	default = "kafka"
}

variable "vpc_id"                 {
	default = "vpc-03199665"

}

variable "public_subnet_id"             {
	default = "subnet-1474435d"
	description = "The public subnet id"
}

variable "vpc_cidr"               {
	default = "10.0.0.0/16"
}

variable "ami_id"             {
	default = "ami-6d1c2007"
}
