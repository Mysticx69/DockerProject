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
