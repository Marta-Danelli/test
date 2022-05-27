variable "region" {
  type    = string
}

variable "cidr_block_vpc" {
  type    = string
}

variable "cidr_private" {
  type    = list(string)
}

variable "cidr_public" {
  type    = list(string)
}

variable "sub_number" {
  type    = number
}

variable "availability_zone" {
  type    = string 
}

variable "ami_private_instance" {
  type    = string
}

variable "private_instance_type" {
  type    = string
}

variable "instance_type_bastion" {
  type    = string
}

variable "ami_bastion" {
  type    = string
}

