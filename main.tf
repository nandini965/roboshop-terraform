module "vpc" {
  source     = "git::https://github.com/nandini965/tf-vpc-module.git"
  for_each   = var.vpc
  cidr_block = each.value["cidr_block"]
  subnets    = each.value["subnets"]
 tags        = local.tags
 env = var.env
 vpc_id = "var.vpc_id"
 name = "var.name"
}