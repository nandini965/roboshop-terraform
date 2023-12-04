locals {
  vpc_id = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  tags   = {
    business_unit = "ecommerce"
    business_type = "retail"
    project_name  = "roboShop"
    cost_center   = 100
    env           = var.env
  }
}
