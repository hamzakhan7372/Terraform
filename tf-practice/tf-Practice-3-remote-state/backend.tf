terraform {
  backend "s3" {
    bucket         = "terraform-practice-bucket-hamza"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "hamza-terraform-remote-state-table"
  }
}
