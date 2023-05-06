locals {
  s3_bucket_name = "terraform-state-nirg1"
  access_key     = "xxx"
  secret_key     = "xxx"
}

variable "s3_bucket_name" {
  type    = string
  default = "a"
}

###
### terraform init -reconfigure
###
# terraform {
#   backend "s3" {
#     # Replace this with your bucket name!
#     bucket = "terraform-state-nirg1"
#     key    = "terraform.tfstate"
#     region = "us-east-1"
#     # Replace this with your DynamoDB table name!
#     dynamodb_table = "terraform-up-and-running-locks"
#     encrypt        = true
#     access_key     = "xxx"
#     secret_key     = "xxx"
#   }
# }

### Step 01 - Create the bucket
resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform-state-nirg1"
  acl    = "private"

  # Force deletion of non-empty buckets
  force_destroy = true
  tags = {
    Name = "Terraform state"
  }

  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.terraform-state.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["USER:arn"]
    }

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:GetBucketPolicy",
      "s3:PutBucketPolicy"
    ]

    resources = [
      aws_s3_bucket.terraform-state.arn,
      "${aws_s3_bucket.terraform-state.arn}/*",
    ]
  }
}

# Step 02 - Create dynamodb_table
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.terraform-state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform-state" {
  name = "terraform-state"
  # read_capacity  = 20
  # write_capacity = 20
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
