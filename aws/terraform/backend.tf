terraform {
  backend "s3" {
    bucket = "harada-material-bucket"
    key    = "terraform.tfvars"
    region = "ap-southeast-1"
  }
}