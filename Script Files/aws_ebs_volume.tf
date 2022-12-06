# EBS Volume

resource "aws_ebs_volume" "ebs-project1" {
  availability_zone = "eu-west-2a"
  size              = 05

  tags = {
    Name = "terraform-ebs1"
  }
}
