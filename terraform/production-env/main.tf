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
  user_data              = file("./scripts/user-data_Ansible.sh")
  vpc_security_group_ids = [module.Networking.allow_all_sg_id]
  private_ip             = "10.150.2.14"

  provisioner "file" {

    source      = "/home/user/.ssh/labsuser.pem"
    destination = "/home/ubuntu/.ssh/labsuser.pem"

    connection {

      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/user/.ssh/labsuser.pem")
      host        = self.public_ip

    }

  }

  provisioner "file" {

    source      = "/home/user/.ssh/id_rsa"
    destination = "/home/ubuntu/.ssh/id_rsa"


    connection {

      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/user/.ssh/labsuser.pem")
      host        = self.public_ip

    }
  }


  provisioner "file" {

    source      = "/home/user/.ssh/config"
    destination = "/home/ubuntu/.ssh/config"


    connection {

      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/user/.ssh/labsuser.pem")
      host        = self.public_ip

    }
  }

  provisioner "file" {

    source      = "/etc/hosts"
    destination = "/tmp/hosts"



    connection {

      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/user/.ssh/labsuser.pem")
      host        = self.public_ip

    }

  }

  provisioner "remote-exec" {

    inline = [

      "sudo mv /tmp/hosts /etc/hosts",
      "sudo chmod 600 /home/ubuntu/.ssh/id_rsa"
    ]


    connection {

      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/user/.ssh/labsuser.pem")
      host        = self.public_ip

    }

  }

  tags = {
    Name = "Dev_Tools"
  }

}

resource "aws_eip" "Dev_tools_EIP" {

  instance = aws_instance.Dev_Tools.id
  vpc      = true

}


resource "aws_instance" "NAS" {

  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  key_name               = "vockey"
  subnet_id              = element(element(module.Networking.public_subnets_id, 1), 1)
  vpc_security_group_ids = [module.Networking.allow_all_sg_id]
  private_ip             = "10.150.2.15"


  tags = {
    Name = "NAS"
  }

}

