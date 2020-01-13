#-----------------------------------------
#My terraform
#Build Web Server during Bootstrap

provider "aws" {
  region = "eu-central-1"
}

/*коментарий*/
resource "aws_instance" "mywebserver" {
    ami                    = "ami-0cc0a36f626a4fdf5" #Ubuntu
    instance_type          = "t2.micro"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]
    key_name               = "key_for_terraform"
    user_data              = file("user_data.sh")

  tags = {
    Name = "Keepalived build by Terraform"
    Owner = "anatoliykv"
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "allow_tls_ssh"
  description = "My Security group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]# add a CIDR block here
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]# add a CIDR block here
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebServer Security Group Terraform"
    Owner = "anatoliykv Terraform"
  }
}
