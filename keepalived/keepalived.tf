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
    user_data = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install nginx -y
#keepalived_install
sudo apt-get install build-essential libssl-dev
wget https://www.keepalived.org/software/keepalived-2.0.19.tar.gz
tar xzvf keepalived*
cd keepalived*
./configure
make
sudo make install
EOF

  tags = {
    Name = "WebServer Build by Terraform"
    Owner = "anatoliykv"
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "allow_tls"
  description = "My Security group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]# add a CIDR block here
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
