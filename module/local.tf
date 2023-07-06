locals {
  db_commands = [
  "rm -rf roboshop-shell",
  "git clone https://github.com/nandini965/roboshop-shell.git",
"cd roboshop-shell",
"sudo bash ${var.component_name}.sh ${var.password}"
]
  app_commands = [
"sudo labauto"
 "ansible-pull -i localhost -u https://github.com/nandini965/roboshop-ansible roboshop.yml -e env=${var.env} -e role_name=${var.component_name}"
]
}