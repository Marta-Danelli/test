terraform {
    required_version = ""

    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws" {
    region = var.region
}

#chiamata modulo vpc

#chiamata modulo ec2