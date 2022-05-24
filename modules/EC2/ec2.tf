resource "aws_instance" "istanza" {
  count         = var.numero_istanze_private
  ami           = var.istanza_ami_privata
  instance_type = var.tipo_istanza_privata

  tags = {
    Name = "Istanza ${count.index}"
  }
}

