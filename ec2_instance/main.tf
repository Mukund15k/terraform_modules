provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "first_instance" {
    ami = "ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    tags = {
        Name = "first_instance"
    }  
}
output "public_ip" {
  value = aws_instance.first_instance.public_ip
}