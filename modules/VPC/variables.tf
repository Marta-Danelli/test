variable cidr_vpc {
    type    = string
    default = "10.0.0.0/26"
}

variable cidr_subnet_privata {
    type    = list
    default = ["fare calcolo"]
}

variable cidr_subnet_pubblica {
    type    = list
    default = ["fare calcolo"]
}

variable numero_subnet {
    type    = number
    default = 2
}

