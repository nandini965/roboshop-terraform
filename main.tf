module "vpc" {
  source     = "git::https://github.com/nandini965/tf-vpc-module.git"
  for_each   = var.vpc
  cidr_block = each.value["cidr_block"]
  subnets    = each.value["subnets"]
 tags        = local.tags
 env = var.env
  vpc_id = var.vpc
 azs = "var.azs"
}
  module "app" {
  source        = "git::https://github.com/nandini965/tf-module-app.git"
  for_each      = var.app
  instance_type = each.value["instance_type"]
  subnet_ids     = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnet_ids", null)
}
#lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnet_ids", null)


