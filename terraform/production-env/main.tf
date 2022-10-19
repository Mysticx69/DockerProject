locals {
  region                        = "us-east-1"
  production_availability_zones = ["${local.region}a", "${local.region}b", "${local.region}c"]
}

module "Networking" {
  source               = "../modules/Networking"
  region               = "us-east-1"
  environment          = "DockerProject-CPE"
  vpc_cidr             = "10.150.0.0/16"
  public_subnets_cidr  = ["10.150.1.0/24", "10.150.2.0/24"]
  private_subnets_cidr = ["10.150.100.0/24", "10.150.200.0/24"]
  availability_zones   = local.production_availability_zones

}


module "Multiple_EC2" {

  source                 = "../modules/Multiple_EC2"
  ami                    = "ami-08c40ec9ead489470"
  environment            = "DockerProjectCPE"
  instance_type          = "t2.micro"
  EC2_counter            = 3
  subnet_id              = element(element(module.Networking.public_subnets_id, 1), 1)
  key_name               = "vockey"
  vpc_security_group_ids = [module.Networking.allow_all_sg_id]


}


resource "aws_instance" "Dev_Tools" {

  ami                         = "ami-08c40ec9ead489470"
  instance_type               = "t2.micro"
  subnet_id                   = element(element(module.Networking.public_subnets_id, 1), 1)
  key_name                    = "vockey"
  vpc_security_group_ids      = [module.Networking.allow_all_sg_id]
  associate_public_ip_address = true


  tags = {
    Name = "Dev_Tools"
  }

}
