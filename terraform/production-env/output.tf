### Networking Module

output "vpc_id" {

  value = module.Networking.vpc_id
}

output "public_subnets_id" {

  value = module.Networking.public_subnets_id
}

output "private_subnets_id" {

  value = module.Networking.private_subnets_id

}

output "public_route_table" {

  value = module.Networking.public_route_table

}

output "default_sg_id" {

  value = module.Networking.default_sg_id

}


### Multiple EC2 Module

output "EC2_privateIP" {

  value = module.Multiple_EC2.EC2_PrivateIP

}

output "EC2_name" {

  value = module.Multiple_EC2.EC2_name

}
