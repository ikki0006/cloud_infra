resource "aws_s3_bucket" "log-bucket" {
  bucket = "${var.env}-one-alb-log-bucket"
  acl    = "private"
}