variable "vpc_id" {
  default = "vpc-b9c578df"
  description = "Since I'm not using the default VPC, I have to specify one"
}

variable "subnet_id" {
  default     = "subnet-44c2e50d"
  description = "subnet id"
}

variable "server_port" {
  default     = "8080"
  description = "The port the server will use for HTTP requests"
}


variable "list_example" {
  description = "An example of a list in Terraform"
  type        = "list"
  default     = [1, 2, 3]
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