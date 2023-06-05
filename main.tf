provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web_instance" {
  ami                  = "ami-0c94855ba95c71c99"
  instance_type        = "t2.micro"
  iam_instance_profile = "LabInstanceProfile"
  key_name             = "week1-dev"

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install docker -y
    service docker start
    usermod -a -G docker ec2-user
 EOF
}

resource "aws_ecr_repository" "webapp_repo" {
  name = "web_app"
}

resource "aws_ecr_repository" "mysql_repo" {
  name = "my_sql"
}
