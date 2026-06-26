provider "aws" {
  profile = "<FM1_1>"
  region  = "<FM1_2>"
}

resource "aws_s3_bucket" "lab_bucket" {
  bucket = "<FM1_3>"

  tags = {
    Name        = "Terraform Lab Bucket"
    Environment = "Lab"
  }
}

resource "aws_instance" "lab_ec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "<FM1_4>"

  tags = {
    Name        = "Terraform Lab EC2"
    Environment = "Lab"
  }
}

resource "aws_iam_user" "lab_user" {
  name = "<FM1_5>"

  tags = {
    Name        = "Terraform Lab User"
    Environment = "Lab"
  }
}

resource "aws_iam_policy" "lab_user_s3_ec2_policy" {
  name = "lab-user-s3-ec2-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation",
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = [
          "arn:aws:s3:::*",
          "arn:aws:s3:::*/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:RebootInstances"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "lab_user_policy_attachment" {
  user       = aws_iam_user.lab_user.name
  policy_arn = aws_iam_policy.lab_user_s3_ec2_policy.arn
}
