# private instance 1

resource "aws_instance" "instance_1" {
  ami                    = var.ami_private
    root_block_device {
    encrypted = true
  }
  instance_type          = var.instance_type_private
  availability_zone      = var.az
  subnet_id              = var.subnet_id_private[0]  
  vpc_security_group_ids = [aws_security_group.private.id]

  tags = {
    Name = "Private instance 1"
  }
}


# private instance 2

resource "aws_instance" "instance-2" {

  ami = var.ami_private
  root_block_device {
    encrypted = true
  }
  instance_type          = var.instance_type_private
  availability_zone      = var.az
  subnet_id              = var.subnet_id_private[1] 
  vpc_security_group_ids = [aws_security_group.private.id]

  tags = {
    Name = "Private instance 2"
  }
}

# private instance security group

resource "aws_security_group" "private" {

  vpc_id = var.vpc_id

  ingress {
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











