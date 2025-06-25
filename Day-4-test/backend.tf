# terraform {
#   backend "s3" {
#     bucket = "my-bucket-name-imran-124786"
#     key    = "imran-terraform-state/terraform.tfstate"
#     region = "us-east-1"
#     #dynamodb_table = "terraform-dynamodb-table-imran-124786"
#   }
# }
terraform {
  backend "s3" {
    bucket         = "my-bucket-name-imran-124786"
    key            = "imran-terraform-state/terraform.tfstate"
    region         = "us-east-1"
    #dynamodb_table = "terraform-dynamodb-table-imran-124786"
  }
}
