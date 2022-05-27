variable "subnet_id" {
  type = list(any)
}

variable "ami_bastion" {
  type = string
}

variable "bastion_type" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}