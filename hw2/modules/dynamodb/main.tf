resource "aws_dynamodb_table" "user_logins" {
  name           = var.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity

  hash_key  = "UserID"
  range_key = "Timestamp"

  attribute {
    name = "UserID"
    type = "S"
  }
  attribute {
    name = "Timestamp"
    type = "N"
  }

  tags = {
    Name = var.table_name
  }
}
