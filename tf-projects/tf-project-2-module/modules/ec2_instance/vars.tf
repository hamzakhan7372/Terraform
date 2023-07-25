#ec2.tf variables
variable "ec2-ami" {
  default = "ami-053b0d53c279acc90"
}
variable "user" {
  default = "ubuntu"
}  

variable "subnet-pub-1" {
  type = string
  default = ""
}

variable "security-group-1" {
  default = ""
} 