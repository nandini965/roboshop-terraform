resource "aws_instance" "frontend" {
  ami           = "ami-0b5a2b5b8f2be4ec2"
  instance_type = "t3.small"

  tags = {
    Name = "frontend"
  }



  resource "aws_instance" "mongodb" {
    ami           = "ami-0b5a2b5b8f2be4ec2"
    instance_type = "t3.small"

    tags = {
      Name = "mongodb"
    }




    resource "aws_instance" "catalogue" {
      ami           = "ami-0b5a2b5b8f2be4ec2"
      instance_type = "t3.small"

      tags = {
        Name = "catalogue"
      }
      resource "aws_instance" "redis" {
        ami           = "ami-0b5a2b5b8f2be4ec2"
        instance_type = "t3.small"

        tags = {
          Name = "redis"
        }




        resource "aws_instance" "user" {
          ami           = "ami-0b5a2b5b8f2be4ec2"
          instance_type = "t3.small"

          tags = {
            Name = "user"
          }



          resource "aws_instance" "cart" {
            ami           = "ami-0b5a2b5b8f2be4ec2"
            instance_type = "t3.small"

            tags = {
              Name = "cart"
            }

            resource "aws_instance" "mysql" {
              ami           = "ami-0b5a2b5b8f2be4ec2"
              instance_type = "t3.small"

              tags = {
                Name = "cart"
              }



              resource "aws_instance" "shipping" {
                ami           = "ami-0b5a2b5b8f2be4ec2"
                instance_type = "t3.small"

                tags = {
                  Name = "shipping"
                }



              resource "aws_instance" "rabbitmq" {
                ami           = "ami-0b5a2b5b8f2be4ec2"
                instance_type = "t3.small"

                tags = {
                  Name = "rabbitmq"
                }
                resource "aws_instance" "payment" {
                  ami           = "ami-0b5a2b5b8f2be4ec2"
                  instance_type = "t3.small"

                  tags = {
                    Name = "payment"
                  }
                }