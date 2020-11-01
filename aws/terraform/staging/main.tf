terraform {
  required_version = "~> 0.13"

    backend "s3" {
    bucket = "harada-terraform-bucket"
    key    = "terraform.tfvars"
    region = "ap-northeast-1"
  }

}

# providerの設定
provider "aws" {
    region = "ap-northeast-1"
}

module "dev" {
  source = "../common"
  env = var.env
  vpc_cidr = var.vpc_cidr
}