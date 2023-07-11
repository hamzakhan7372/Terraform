variable "region_virginia" {
    default = "us-east-1"
}

variable "zone_1" {
    default = "us-east-1a"
}

variable "ami_ids" {
    type = map
    default = {
        us-east-1 = "ami-022e1a32d3f742bd8"
        us-east-2 = "ami-0e820afa569e84cc1"
    }
}