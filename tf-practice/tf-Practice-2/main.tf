module "module-ec2" {
  source     = "./resources/ec2"
  key-name-1 = "Key-Pair-Groups"
  ami-1      = "ami-053b0d53c279acc90"
}

module "module-s3" {
    source = "./resources/s3"
}