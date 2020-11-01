# providerの設定
provider "aws" {
    region = "ap-northeast-1"
}

# common moduleを呼び出す
module "common" {
  source = "../common"

  # moduleに渡す変数を列挙
  prefix = "sta"
  ip_subnet = "10.0.0.0/16"
}