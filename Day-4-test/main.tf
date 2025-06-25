module "ec2_instance" {
  source = "./modules/ec2-instance"
  instance_type_id = "t2.micro"
  ami_id = "ami-020cba7c55df1f615" # Example AMI ID, replace with a valid one for your region
}

module "aws_s3_bucket" {
  source = "./modules/s3-bucket"
  bucket_name_value = "my-bucket-name-imran-124786" # Ensure this name is globally unique

}

# module "aws_dynamodb_table" {
#   source = "./modules/dynamoDB"
#   dynamodb_table_name = "terraform-dynamodb-table-imran-124786" # Ensure this name is globally unique
# }


module "aws_dynamodb_table" {
  source = "./modules/dynamoDB"
  dynamodb_table_name = "terraform-dynamodb-table-imran-124786"
}

