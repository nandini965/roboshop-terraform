module "vpc" {
  source = "git::https://github.com/nandini965/tf-vpc-module.git"

  for_each   = var.vpc
  cidr_block = each.value["cidr_block"]
  tags       = local.tags
}