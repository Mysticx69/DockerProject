variable "ami" {

  type        = string
  description = "Ami ID to deploy"

}

variable "instance_type" {

  type        = string
  description = "Instance type (T2.micro... etc)"

}


variable "EC2_counter" {

  type        = number
  description = "Number of EC2 to deploy"

}

variable "environment" {

  type        = string
  description = "Environement where EC2 are deployed"

}

variable "subnet_id" {

  type        = string
  description = "Subnet ID to spawn EC2 in"
  default     = null
}

