resource "aws_instance" "demo_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type_id

  tags = {
    Name = "DemoInstance"
  }
  
}