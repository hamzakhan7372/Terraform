resource "aws_instance" "ec2-first" {
    ami = var.ami-1
    key_name = var.key-name-1
    instance_type = "t2.micro"
}