env = "dev"
bastion_cidr = ["172.31.94.29/32"]
default_vpc_id = "vpc-04949aba459233a3b"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_rtid = "rtb-02a1a165ecbd8ef2a"
kms_arn = "arn:aws:kms:us-east-1:121558927746:key/e4d7c861-f016-44b5-8edd-3e79dfdda561"
 vpc = {
  main = {
    cidr_block = "10.0.0.0/16"
    subnets = {
     public = {
       name = "public"
     cidr_block = ["10.0.0.0/24", "10.0.1.0/24" ]
     azs        =  ["us-east-1a", "us-east-1b"]
    }
      web = {
        name = "web"
        cidr_block = ["10.0.2.0/24", "10.0.3.0/24" ]
        azs        =  ["us-east-1a", "us-east-1b"]
      }
      app = {
        name = "app"
        cidr_block = ["10.0.4.0/24", "10.0.5.0/24" ]
        azs        =  ["us-east-1a", "us-east-1b"]
      }

      db = {
        name = "db"
        cidr_block = ["10.0.6.0/24", "10.0.7.0/24" ]
        azs        =  ["us-east-1a", "us-east-1b"]
      }
    }
  }
}
 app = {
   frontend = {
     name             = "frontend"
     instance_type    = "t3.small"
     subnet_name      = "web"
     desired_capacity = 2
     max_size         = 10
     min_size         = 2
     allow_app_cidr   = "public"
   }
   catalogue = {
     name             = "catalogue"
     instance_type    = "t3.small"
     subnet_name      = "app"
     desired_capacity = 2
     max_size         = 10
     min_size         = 2
     allow_app_cidr   = "web"
   }
 }
  // user = {
   //  instance_type = "t3.small"
     //subnet_name = "app"
   //}
   //cart = {
    // instance_type = "t3.small"
     //subnet_name = "app"
   //}
  // shipping = {
    // instance_type = "t3.small"
     //subnet_name = "app"
   //}
   //payment = {
    // instance_type = "t3.small"
     //subnet_name = "app"
   //}
//}
docdb = {
  main = {
    subnet_name = "db"
    allow_db_cidr = "app"
    engine_version = "4.0.0"
   // instance_count = 1
    //instance_class = "db.t3.medium"
  }
}


