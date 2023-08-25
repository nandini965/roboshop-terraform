output "vpc" {
  value = element(lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnet_ids", null), 0)
}

//lookup(lookup(module.vpc, "main", null), "subnets", null)