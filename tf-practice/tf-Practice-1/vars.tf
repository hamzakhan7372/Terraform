variable "os" {
  type = string
  description = "ami id of instance"
  default = "ami-053b0d53c279acc90"
}

variable "az" {
  type = string
  description = "availibility zone"
  default = "us-east-1c"
}

variable "instance_type" {
  type = string
  description = "Instance type"
  default = "t2.micro"
}