resource "aws_instance" "Shikha" {
    
  ami = var.aws_instance_ami_id
  instance_type = var.instance_type

  tags = {
    Name = "FirstVM-Shikha"
    ENV = "DEV"
  }
}