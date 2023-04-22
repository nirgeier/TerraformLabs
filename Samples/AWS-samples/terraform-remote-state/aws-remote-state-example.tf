
resource "aws_s3_bucket" "bucket" {
  bucket = "my-tf-test-bucket"
  acl    = "private"

  tags = {
    Name        = "CodeWizard bucket"
    Environment = "dev"
  }
}
