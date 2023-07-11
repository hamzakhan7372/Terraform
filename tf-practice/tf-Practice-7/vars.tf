variable "region" {
    default = "us-east-1"
}

variable "az-1" {
    default = "us-east-1a"
}

variable "amis" {
    type = map
    default = {
        us-east-1 = "ami-022e1a32d3f742bd8"
        us-east-2 = "ami-0e820afa569e84cc1"
    }
}

variable "user" {
    default = "ec2-user"
}