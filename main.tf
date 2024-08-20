# Specify the provider
provider "aws" {
  region = "us-west-2"  # Replace with your preferred AWS region
}

# Define a key pair to access the EC2 instance
resource "aws_key_pair" "web_key" {
  key_name   = "web_key"
  public_key = file("~/.ssh/id_rsa.pub")  # Replace with your public key file path
}

# Create a security group to allow HTTP traffic
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow HTTP traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define an EC2 instance
resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI (replace with the AMI ID for your region)
  instance_type = "t2.micro"

  key_name      = aws_key_pair.web_key.key_name
  security_groups = [aws_security_group.web_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "WebServer"
  }
}

# Output the public IP of the EC2 instance
output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}

