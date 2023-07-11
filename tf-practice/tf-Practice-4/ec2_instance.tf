
resource "aws_instance" "Terraform_practice_instance" {
  ami                    = var.ami_ids[var.region_virginia]
  availability_zone = var.zone_1
  instance_type          = "t2.micro"
  key_name               = "Key-Pair-Groupsr"
  vpc_security_group_ids = [ "sg-0d75a788eb003beba" ]
  tags = {
    "Name" = "Terraform_practice_instance"
    
  }
}