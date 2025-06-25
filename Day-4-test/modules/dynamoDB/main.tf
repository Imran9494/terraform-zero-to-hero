# resource "aws_dynamodb_table" "terraform-dynamodb-table" {
#     name         = var.dynamodb_table_name
#     billing_mode = "PAY_PER_REQUEST"
#     hash_key = "lock_id"


#     attribute {
#         name = "lock_id"
#         type = "S"
#     }

# }
#modules/dynamoDB/main.tf
resource "aws_dynamodb_table" "terraform_lock" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "lock_id"

  attribute {
    name = "lock_id"
    type = "S"
  }
}
