module "vpc" {
  source = "https://github.com/nandini965/tf-vpc-module.git"
  for_each = var.vpc
  cidr_block = each.value[cidr_block]
}