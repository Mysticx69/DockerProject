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
  subnet_id              = "subnet-0b63dc099426bd122"
  key_name               = "vockey"
  vpc_security_group_ids = ["sg-04e6f6381e366f855"]

}


resource "aws_instance" "Ansible" {

  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-0b63dc099426bd122"
  key_name               = "vockey"
  vpc_security_group_ids = ["sg-04e6f6381e366f855"]


  tags = {
    Name = "Ansible"
  }

}
