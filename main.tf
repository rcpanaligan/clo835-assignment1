provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a" 
}

resource "aws_security_group" "instance_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_instance" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  iam_instance_profile   = "LabInstanceProfile"
  subnet_id              = aws_subnet.public.id
  key_name               = "week1-dev"
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
}

resource "aws_ecr_repository" "webapp_repo" {
  name = "web_app"
}

resource "aws_ecr_repository" "mysql_repo" {
  name = "my_sql"
}
