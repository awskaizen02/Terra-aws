resource "aws_instance" "demo" {
  ami = "ami-0d473344347276854"
  instance_type = "t2.micro"
 tags = {
   Name = "Demo-Ins"
 }
}