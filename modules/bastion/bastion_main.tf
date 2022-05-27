# bastion host 1

resource "aws_instance" "bastion_1" {
  ami                    = var.ami_bastion
  instance_type          = var.bastion_type
  subnet_id              = var.subnet_id[0]
  vpc_security_group_ids = [aws_security_group.bastion_host.id]

  tags = {
    Name = "bastion-host-1"
  }
}

#bastion host 2

resource "aws_instance" "bastion_2" {
  ami                    = var.ami_bastion
  instance_type          = var.bastion_type
  subnet_id              = var.subnet_id[1]
  vpc_security_group_ids = [aws_security_group.bastion_host.id]

  tags = {
    Name = "bastion-host-2"
  }
}

#security group bastion host

resource "aws_security_group" "bastion_host" {

  vpc_id = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

