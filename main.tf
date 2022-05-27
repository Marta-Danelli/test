terraform {
  required_version = "~> 1.1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.8.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# vpc module

module "vpc" {
  source = "./modules/VPC"

  cidr_vpc             = var.cidr_block_vpc
  cidr_private_subnet  = var.cidr_private
  cidr_public_subnet   = var.cidr_public
  subnet_number        = var.sub_number
  az                   = var.availability_zone

}

# module EC2

module "EC2" {
  source = "./modules/EC2"

  ami_private           = var.ami_private_instance
  instance_type_private = var.private_instance_type
  az                    = var.availability_zone
  subnet_id_private     = module.vpc.private_subnet_id 
  vpc_id = module.vpc.vpc_id
  vpc_cidr_block        = var.cidr_block_vpc

}

# module bastion

module "bastion" {
  source = "./modules/bastion"

  bastion_type = var.instance_type_bastion
  ami_bastion  = var.ami_bastion
  subnet_id    = module.vpc.public_subnet_id
  vpc_id       = module.vpc.vpc_id
  vpc_cidr_block = var.cidr_block_vpc
}