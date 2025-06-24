resource "aws_instance" "sample_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type_id

  tags = {
    Name = "SampleInstance"
  }
  
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "sampleawsbucket" {
  bucket = "sample-aws-bucket-${random_id.bucket_suffix.hex}"
  acl    = "private"

  tags = {
    Name        = "SampleBucket"
    Environment = "Test"
  }
}

# This resource creates an S3 bucket object in the specified bucket
# with a sample content and tags.
resource "aws_s3_bucket_object" "sample_object" {
  bucket = aws_s3_bucket.sampleawsbucket.id
  key    = "sample-object.txt"
  content = "This is a sample object in the S3 bucket."

  tags = {
    Name        = "SampleObject"
    Environment = "Test"
  }
}