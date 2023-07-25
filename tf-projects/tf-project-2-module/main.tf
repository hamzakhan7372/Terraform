module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source = "./modules/ec2_instance"
  subnet-pub-1 = module.vpc.subnet-pub-1
  security-group-1 = module.vpc.security-group-1
}