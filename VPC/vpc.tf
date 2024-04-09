##VPC Creation##

resource "aws_vpc" "vpc1" {
  cidr_block = var.cidr_block

  instance_tenancy = "default"

  tags = {
    Name = "VPC1_Shikha"
  }
}

##Subnet Creation##

resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  availability_zone       = each.value.availability_zone
  tags = {
    Name = each.key
  }
  for_each = var.Subnets
}


##Security Group Creation##

resource "aws_security_group" "public_HTTP_SSH" {
  name        = "Allow_Public_HTTP_SSH"
  description = "Allow HTTP and SSH from anywhere"
  vpc_id      = aws_vpc.vpc1.id

  dynamic "ingress" {
    for_each = var.inbound_rule

    content {
      description = ingress.key
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow_Public_HTTP_SSH_Shikha"
  }

}

resource "aws_security_group" "private_SSH" {
  name        = "Allow_Public_SSH"
  description = "Allow SSH from Public Subnet"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    description = "SSH from Private Subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block_public_subnet]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Private_SSH_Shikha"
  }
}

##Internet Gateway##

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "Internet_Gateway_Shikha"
  }
}

##Route Table ##

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Allow traffic from GW"
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.subnet["public_subnet"].id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "Allow traffic from private Subnet"
  }
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.subnet["private_subnet"].id
  route_table_id = aws_route_table.private_route.id
}