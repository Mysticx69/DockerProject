resource "aws_instance" "EC2" {

  # Nombre d'EC2 à déployer
  count = var.EC2_counter

  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id


  tags = {

    Name = "${var.environment}-VM${count.index + 1}"
  }


}
