module "vpc" {
  source    = "git::https://github.com/nandini965/tf-vpc-module.git"
  for_each   = var.vpc
  cidr_block = each.value["cidr_block"]
  subnets    = each.value["subnets"]
 tags        = local.tags
 env = var.env
 vpc_id = var.vpc
  default_vpc_id = var.default_vpc_id
  default_vpc_cidr = var.default_vpc_cidr
  default_vpc_rtid = var.default_vpc_rtid
}

module "app" {
  depends_on = [module.vpc, module.docdb, module.rds, module.elasticache, module.rabbitmq, module.alb]
  source           = "git::https://github.com/nandini965/tf-module-app.git"
  for_each          = var.app
  instance_type     = each.value["instance_type"]
  name              = each.value["name"]
  desired_capacity  = each.value["desired_capacity"]
  max_size          = each.value["max_size"]
  min_size          = each.value["min_size"]
  app_port          = each.value["app_port"]
  listener_priority = each.value["listener_priority"]
  dns_name          = each.value["name"] == "frontend" ? each.value["dns_name"] : "${each.value["name"]}-${var.env}"
  parameters        = each.value["parameters"]

  subnet_ids     = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnets_ids", null)
  vpc_id         = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  allow_app_cidr = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["allow_app_cidr"], null), "subnets_cidr", null)
  listener_arn   = lookup(lookup(module.alb, each.value["lb_type"], null), "listener_arn", null)
  lb_dns_name    = lookup(lookup(module.alb, each.value["lb_type"], null), "dns_name", null)

  env          = var.env
  bastion_cidr = var.bastion_cidr
  tags         = merge(local.tags, { Monitor = "true" })
  domain_name  = var.domain_name
  domain_id    = var.domain_id
  kms_arn      = var.kms_arn
  monitor_cidr = var.monitor_cidr
}

module "docdb" {
 source = "git::https://github.com/nandini965/tf-module-docdb.git"

 for_each       = var.docdb
  subnets        = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnets_ids", null)
  allow_db_cidr  = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["allow_db_cidr"], null), "subnets_cidr", null)
  engine_version = each.value["engine_version"]
  instance_count = each.value["instance_count"]
   instance_class = each.value["instance_class"]


  tags    = local.tags
  env     = var.env
  vpc_id  = local.vpc_id
  kms_arn = var.kms_arn
}



module "rds" {
  source = "git::https://github.com/nandini965/tf-module-rds.git"

  for_each       = var.rds
  subnets        = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnets_ids", null)
  allow_db_cidr  = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["allow_db_cidr"], null), "subnets_cidr", null)
  engine_version = each.value["engine_version"]
  instance_count = each.value["instance_count"]
  instance_class = each.value["instance_class"]


  tags    = local.tags
  env     = var.env
  vpc_id  = local.vpc_id
  kms_arn = var.kms_arn
}


module "elasticache" {
  source = "git::https://github.com/nandini965/tf-module-elasticache.git"

  for_each       = var.elasticache
  subnets        = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnets_ids", null)
  allow_db_cidr  = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["allow_db_cidr"], null), "subnets_cidr", null)
  engine_version = each.value["engine_version"]
  num_node_groups = each.value["num_node_groups"]
  node_type = each.value["node_type"]
  replicas_per_node_group = each.value["replicas_per_node_group"]
  tags    = local.tags
  env     = var.env
  vpc_id  = local.vpc_id
  kms_arn = var.kms_arn
}
module "rabbitmq" {
  source = "git::https://github.com/nandini965/tf-module-amazonmq.git"

  for_each       = var.rabbitmq
  subnets        = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnets_ids", null)
  allow_db_cidr  = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["allow_db_cidr"], null), "subnets_cidr", null)
  instance_type = each.value["instance_type"]
  tags    = local.tags
  env     = var.env
  vpc_id  = local.vpc_id
  kms_arn = var.kms_arn
  bastion_cidr = var.bastion_cidr
  domain_id = var.domain_id
}

module "alb" {
 source = "git::https://github.com/nandini965/tf-module-alb.git"

  for_each       = var.alb
  subnets        = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnets_ids", null)
  allow_alb_cidr = each.value["name"] == "public" ? ["0.0.0.0/0"] : concat(lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["allow_alb_cidr"], null), "subnets_cidr", null),    )
  name           = each.value["name"]
  internal       = each.value["internal"]
  dns_name = each.value["name"] == "frontend" ? each.value["dns_name"] : "${each.value["name"]}-${var.env}"


  tags   = local.tags
  env    = var.env
  vpc_id = local.vpc_id
  domain_id    = var.domain_id
}

module "eks" {
  source             = "git::https://github.com/nandini965/tf-module-eks.git"
   ENV                = var.env
  eks_version        = 1.27
  PRIVATE_SUBNET_IDS = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null), "subnets_ids", null)
  PUBLIC_SUBNET_IDS  = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "public", null), "subnets_ids", null)
  DESIRED_SIZE       = 2
  MAX_SIZE           = 2
  MIN_SIZE           = 2
  kms_arn            = var.kms_arn
}

## Load Runner
data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners      = ["973714476881"]
}

resource "aws_instance" "load" {
  ami                    = data.aws_ami.ami.id
  instance_type          = "t3.medium"
  vpc_security_group_ids = ["sg-0375b4f0e05aa6edd"]
  tags = {
    Name = "load-runner"
  }
}
resource "null_resource" "load" {
  provisioner "remote-exec" {

    connection {
      host     = aws_instance.load.private_ip
      user     = "root"
      password = "DevOps321"
    }

    inline = [
      "curl -s https://raw.githubusercontent.com/linuxautomations/labautomation/master/tools/docker/install.sh | bash",
      "docker pull robotshop/rs-load"
    ]


  }
}

