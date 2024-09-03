# Create an S3 bucket for Django static and media files
resource "aws_s3_bucket" "prod_media" {
  bucket = "${var.prod_media_bucket}-${var.account_id}"  # Use specified account ID for uniqueness
  acl    = "private"  # Ensure all objects are private by default

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

# Manage public access block for the S3 bucket
resource "aws_s3_bucket_public_access_block" "prod_media_block" {
  bucket = aws_s3_bucket.prod_media.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = false  # Allow public bucket policies
  restrict_public_buckets = false
}

# Define a bucket policy allowing public read access only to specific folders
resource "aws_s3_bucket_policy" "prod_media_bucket_policy" {
  bucket = aws_s3_bucket.prod_media.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = [
          "arn:aws:s3:::${aws_s3_bucket.prod_media.id}/media/*",  # Allow public read only for 'media/' directory
          "arn:aws:s3:::${aws_s3_bucket.prod_media.id}/static/*"  # Allow public read only for 'static/' directory
        ]
      }
    ]
  })
}

# IAM user for application to access the S3 bucket
resource "aws_iam_user" "prod_media_bucket" {
  name = "prod-media-bucket"
}

# IAM policy for the IAM user to allow S3 bucket access
resource "aws_iam_user_policy" "prod_media_bucket" {
  user = aws_iam_user.prod_media_bucket.name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "AllowDjangoAppFullAccess",
        Effect   = "Allow",
        Action   = [
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:DeleteObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.prod_media.id}",
          "arn:aws:s3:::${aws_s3_bucket.prod_media.id}/*"
        ]
      }
    ]
  })
}

# IAM access key for the IAM user
resource "aws_iam_access_key" "prod_media_bucket" {
  user = aws_iam_user.prod_media_bucket.name
}


