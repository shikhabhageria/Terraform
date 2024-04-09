module "vpc" {
  source = "../VPC_Module"

  cidr_block = "10.0.0.0/16"

cidr_block_public_subnet = "10.0.16.0/20"

cidr_block_private_subnet = "10.0.32.0/20"

public_ami = "ami-05c969369880fa2c2"

private_ami = "ami-05c969369880fa2c2"

public_instancetype = "t2.micro"

private_instancetype = "t3.micro"

ec2_name = ["Shikha_Private_VM1", "Shikha_Private_VM2", "Shikha_Private_VM3"]

ec2_name_count = ["Shikha_Public_VM1", "Shikha__Public_VM2", "Shikha_Public_VM3"]

Subnets = {

  public_subnet = {
    cidr_block              = "10.0.16.0/20",
    map_public_ip_on_launch = true,
    availability_zone       = "us-west-1b"
  },

  private_subnet = {
    cidr_block              = "10.0.32.0/20",
    map_public_ip_on_launch = false,
    availability_zone       = "us-west-1b"
  }

}

inbound_rule = {

  allow_http = {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  allow_ssh = {

    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

VM = {

  public_vm = {
    ami                         = "ami-05c969369880fa2c2"
    instance_type               = "t2.micro"
    key_name                    = "shikha-key"
    availability_zone           = "us-west-1b"
    associate_public_ip_address = true
    vpc_security_group          = "public_sg"
    subnet_id                   = "public_subnet"
  }

  private_vm = {

    ami                         = "ami-05c969369880fa2c2"
    instance_type               = "t3.micro"
    key_name                    = "shikha-key"
    availability_zone           = "us-west-1b"
    associate_public_ip_address = false
    vpc_security_group          = "private_sg"
    subnet_id                   = "private_subnet"

  }
}

}

terraform {
  backend "s3" {
    bucket = "shikha-terraform"
    key    = "tfstate"
    region = "us-west-1"
    dynamodb_table = "tfstate"
  }
}
