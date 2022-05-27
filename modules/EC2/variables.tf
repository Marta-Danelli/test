variable "ami_private" {
  type = string
}

variable "instance_type_private" {
  type = string
}


variable "az" {
  type = string
}


variable "subnet_id_private" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}