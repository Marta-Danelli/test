variable "cidr_vpc" {
  type    = string
}

variable "cidr_private_subnet" {
  type    = list(string)
}

variable "cidr_public_subnet" {
  type    = list(string)
}

variable "subnet_number" {
  type    = number
}

variable "az" {
  type = string
}
