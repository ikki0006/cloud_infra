terraform {
  required_version = "~> 0.13"

    backend "s3" {
    bucket = "harada-terraform-bucket"
    key    = "terraform.tfvars"
    region = "ap-northeast-1"
    prefix = var.env
  }

}

# providerの設定
provider "aws" {
    region = "ap-northeast-1"
}

module "sta" {
  source = "../../"
  env = var.env
  vpc-cidr = var.vpc-cidr
  public-cidr01 = var.public-cidr01
  public-cidr02 = var.public-cidr02
}