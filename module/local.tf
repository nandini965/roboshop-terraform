locals = {
  Name = var.env != ""? "${var.component_name}_${var.env}" : var.component_name
}