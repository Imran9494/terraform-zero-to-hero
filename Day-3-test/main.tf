provider "aws" {
    region = "us-east-1"
}

module "ec2_instance_sample" {
    source = "./modules/ec2-instance"
    instance_type_id = "t2.micro"
    ami_id = "ami-020cba7c55df1f615" # Example AMI ID, replace with a valid one for your region
}