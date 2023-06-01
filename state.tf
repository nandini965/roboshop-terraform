terraform {
  backend "s3" {
    bucket = "terraform98"
    key    = "roboshop/dev/terraform.tf.state"
    region = "us-east-1"
  }
}
