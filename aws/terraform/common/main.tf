terraform {
  required_version = "~> 0.13"

    backend "s3" {
    bucket = "harada-terraform-bucket"
    region = "ap-northeast-1"
    key = "common.tfstate"
  }

}

# providerの設定
provider "aws" {
    region = "ap-northeast-1"
}