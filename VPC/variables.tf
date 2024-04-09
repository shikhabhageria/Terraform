variable "cidr_block" {

  type        = string
  description = "Public Subnet range"

}

variable "cidr_block_public_subnet" {

  type        = string
  description = "Public Subnet range"

}

variable "cidr_block_private_subnet" {

  type        = string
  description = "Private Subnet range"

}

variable "public_ami" {

  type        = string
  description = "Public AMI"

}

variable "private_ami" {

  type        = string
  description = "Private AMI"

}

variable "public_instancetype" {

  type        = string
  description = "Public Instance Type"

}

variable "private_instancetype" {

  type        = string
  description = "Private Instance Type"

}

variable "ec2_name_count" {

  type        = list(string)
  description = "Number of Instance"

}

variable "ec2_name" {

  type        = set(string)
  description = "Number of Instance"

}

variable "Subnets" {

  type = any
}

variable "inbound_rule" {

  type        = any
  description = "Security Inbound Rule"

}

variable "VM" {

  type        = any
  description = "Ec2 parameters"

}