##convert lower case to upper case
variable "sample" {
  default = "abcxyz"
}

output "sample"{
  value = var.sample
}
