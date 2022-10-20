locals {
  region                        = "us-east-1"
  production_availability_zones = ["${local.region}a", "${local.region}b", "${local.region}c"]


}

module "Networking" {
  source               = "../modules/Networking"
  environment          = "DockerProject-CPE"
  vpc_cidr             = "10.150.0.0/16"
  public_subnets_cidr  = ["10.150.1.0/24", "10.150.2.0/24"]
  private_subnets_cidr = ["10.150.100.0/24", "10.150.200.0/24"]
  availability_zones   = local.production_availability_zones

}


module "Multiple_EC2" {

  source                      = "../modules/Multiple_EC2"
  EC2_counter                 = 4
  ami                         = "ami-08c40ec9ead489470"
  instance_type               = "t2.micro"
  subnet_id                   = element(element(module.Networking.public_subnets_id, 1), 1)
  vpc_security_group_ids      = [module.Networking.allow_all_sg_id]
  associate_public_ip_address = true
  key_name                    = "vockey"
  environment                 = "DockerProjectCPE"


}


resource "aws_instance" "Dev_Tools" {

  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  key_name               = "vockey"
  subnet_id              = element(element(module.Networking.public_subnets_id, 1), 1)
  user_data              = file("./scripts/user-data_installAnsible.sh")
  vpc_security_group_ids = [module.Networking.allow_all_sg_id]
  private_ip             = "10.150.2.15"


  tags = {
    Name = "Dev_Tools"
  }

}

resource "aws_eip" "lb" {

  instance = aws_instance.Dev_Tools.id
  vpc      = true

}
