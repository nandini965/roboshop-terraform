terraform {
  backend "s3" {
    bucket = "terraform92"
    key    = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}

