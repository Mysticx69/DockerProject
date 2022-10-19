variable "ami" {

  type        = string
  description = "Ami ID to deploy"

}

variable "associate_public_ip_address" {

  type        = bool
  description = "Decide if you want auto public IP on your instances"
  default     = false

}
variable "EC2_counter" {

  type        = number
  description = "Number of EC2 to deploy"
  default     = 1

}


variable "environment" {

  type        = string
  description = "Environement where EC2 are deployed"
  default     = "production"

}

variable "instance_type" {

  type        = string
  description = "Instance type (T2.micro... etc)"

}


variable "key_name" {

  type        = string
  description = "Key_pair for EC2"
  default     = null

}


variable "subnet_id" {

  type        = string
  description = "Subnet ID to spawn EC2 in"
  default     = null
}

variable "vpc_security_group_ids" {

  type        = set(string)
  description = "List of SG to attach EC2 to"
  default     = null

}




variable "test" {

}
