provider "aws" {
  profile = ""
  region  = ""
}

resource "aws_s3_bucket" "lab_bucket" {
  bucket = ""

  tags = {
    Name        = "Terraform Lab Bucket"
    Environment = "Lab"
  }
}
