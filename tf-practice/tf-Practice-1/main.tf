provider "aws" {

}

resource "aws_instance" "terraform-vm1" {
  ami               = "ami-053b0d53c279acc90"
  instance_type     = "t2.micro"
  key_name          = "Key-Pair-Groups"
}

resource "aws_instance" "terraform-vm2" {
  ami               = "ami-053b0d53c279acc90"
  instance_type     = "t2.micro"
  key_name          = "Key-Pair-Groups"
  vpc_security_group_ids = [ "sg-06aedbbe8cb43d140" ]
}

resource "aws_instance" "terraform-vm3" {
  ami               = var.os   
  instance_type     = "t2.micro"
  key_name          = "Key-Pair-Groups"
  vpc_security_group_ids = [ "sg-06aedbbe8cb43d140" ]
  availability_zone = var.az
}