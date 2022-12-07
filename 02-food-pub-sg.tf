resource "aws_security_group" "food-sg-ssh-http" {
  name        = "food-ssh-http"
  description = "Allow port 80 and port 22"
  vpc_id      = aws_vpc.food-vpc.id

  ingress {
    description      = "allow ssh for servers"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

 ingress {
    description      = "allow http for web"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "food-web-sg"
  }
}
