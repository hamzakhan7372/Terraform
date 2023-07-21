#vpc.tf variables
variable "az-1" {
  default = "us-east-1a"
}

variable "az-2" {
  default = "us-east-1b"
}

variable "az-3" {
  default = "us-east-1c"
}

#providers.tf variables
variable "region-1" {
  default = "us-east-1"
}


#ec2.tf variables
variable "ec2-ami" {
  default = "ami-053b0d53c279acc90"
}
variable "user" {
  default = "ubuntu"
}