provider "aws" {
	region = "us-east-1"
}
resource "aws_s3_bucket" "my_bucket" {
  bucket = "terraform-s3-lc46377"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

