variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

variable "vpc_id" {
  default = "vpc-990081ff"
  description = "Since I'm not using the default VPC, I have to specify one"
}

variable "region" {
  default = "us-east-1"
  description = "default region"
}

variable "server_port" {
  default     = "8080"
  description = "The port the server will use for HTTP requests"
}


variable "subnet_id" {
  description = "An example of a list in Terraform"
  type        = "list"
  default     = ["subnet-d349619a"]
}

variable "map_example" {
  description = "An example of a map in Terraform"
  type        = "map"

  default = {
    key1 = "value1"
    key2 = "value2"
    key3 = "value3"
  }
}
