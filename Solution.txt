provider "aws" {
  profile = "terraform-user"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "lab_bucket" {
  bucket = "my-unique-terraform-lab-bucket-12345"

  tags = {
    Name        = "Terraform Lab Bucket"
    Environment = "Lab"
  }
}
