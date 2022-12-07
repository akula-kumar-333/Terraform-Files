resource "aws_instance" "food-ec2" {
  ami           = "ami-036e229aa5fa198ba"
  instance_type = "t2.micro"
  key_name = "rishi"
  subnet_id   = aws_subnet.food-sb-pub.id
  vpc_security_group_ids = [aws_security_group.food-sg-ssh-http.id]
  user_data = file("food.sh")

  tags = {
    Name = "food app"
  }
}
