module "ec2_instance" {
  source = "./modules/ec2-instance"
  ami_id  = var.ami_id
  #instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
  instance_type_id =  var.instance_type_id
}