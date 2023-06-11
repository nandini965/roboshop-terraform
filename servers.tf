
 data "aws_ami" "centos" {
   owners      = ["973714476881"]
   most_recent = true
   name_regex  = "Centos-8-DevOps-Practice"
}
 data "aws_security_group" "allow_all" {
   name = "allow-all"
 }

variable "components" {
  default = {
    frontend = {
      name = "frontend"
      instance_type = "t3.small"
    }
    mongodb = {
      name = "mongodb"
      instance_type = "t3.small"
    }
    catalogue = {
      name = "catalogue"
      instance_type = "t3.small"
    }
    redis = {
      name = "redis"
      instance_type = "t3.small"
    }
    user = {
      name = "user"
      instance_type = "t3.small"
    }
    cart = {
      name = "cart"
      instance_type = "t3.small"
    }
     mysql = {
      name = "mysql"
      instance_type = "t3.small"
    }
    shipping = {
      name = "shipping"
      instance_type = "t3.small"
    }
    rabbitmq = {
      name = "rabbitmq"
      instance_type = "t3.small"
    }
    payment = {
      name = "payment"
      instance_type = "t3.small"
    }
  }
}

 resource "aws_instance" "instance" {
   for_each = var.components
   ami           = data.aws_ami.centos.image_id
   instance_type = each.value["instance_type"]
   vpc_security_group_ids = [data.aws_security_group.allow_all.id]

  tags = {
    Name = each.value["name"]
  }
}
 resource "aws_route53_record" "records" {

   for_each = var.components
   zone_id = "Z03435932ULD0BAV8M7RN"
   name    = "${each.value["name"]}-dev.rdevopsb72.store"
   type    = "A"
   ttl     = 30
   records = [aws_instance.instance[each.value["name"]].private_ip]
 }


    //resource "aws_instance" "catalogue" {
      //ami           = data.aws_ami.centos.image_id
      //instance_type = var.instance_type
      //vpc_security_group_ids = [ data.aws_security_group.allow_all.id ]
      //tags = {
        //Name = "catalogue"
      //}
    //}

 //resource "aws_route53_record" "catalogue" {
   //zone_id = "Z03435932ULD0BAV8M7RN"
   //name    = "catalogue-dev.rdevopsb72.store"
   //type    = "A"
   //ttl     = 30
   //records = [aws_instance.catalogue.private_ip]
 //}

      //resource "aws_instance" "redis" {
        //ami           = data.aws_ami.centos.image_id
        //instance_type = var.instance_type
        //vpc_security_group_ids = [ data.aws_security_group.allow_all.id ]
        //tags = {
         //Name = "redis"
        //}
 //}
 //resource "aws_route53_record" "redis" {
   //zone_id = "Z03435932ULD0BAV8M7RN"
   //name    = "redis-dev.rdevopsb72.store"
   //type    = "A"
   //ttl     = 30
   //records = [aws_instance.redis.private_ip]
 //}


   //     resource "aws_instance" "user" {
     //     ami           = data.aws_ami.centos.image_id
       //   instance_type = var.instance_type
         // vpc_security_group_ids = [ data.aws_security_group.allow_all.id ]
          //tags = {
            //Name = "user"
          //}
        //}
 //resource "aws_route53_record" "user" {
   //zone_id = "Z03435932ULD0BAV8M7RN"
   //name    = "user-dev.rdevopsb72.store"
   //type    = "A"
   //ttl     = 30
   //records = [aws_instance.user.private_ip]
 //}

   //       resource "aws_instance" "cart" {
     //       ami           = data.aws_ami.centos.image_id
      //      instance_type = var.instance_type
         //   vpc_security_group_ids = [ data.aws_security_group.allow_all.id ]
        //    tags = {
        //  Name = "cart"
           // }
          //}


 //resource "aws_route53_record" "cart" {
   //zone_id = "Z03435932ULD0BAV8M7RN"
   //name    = "cart-dev.rdevopsb72.store"
   //type    = "A"
  // ttl     = 30
   //records = [aws_instance.cart.private_ip]
 //}


   //         resource "aws_instance" "mysql" {
     //         ami           = data.aws_ami.centos.image_id
       //       instance_type = var.instance_type
            //  vpc_security_group_ids = [ data.aws_security_group.allow_all.id ]

            //  tags = {
              //  Name = "mysql"
              //}
            //}
 //resource "aws_route53_record" "mysql" {
   //zone_id = "Z03435932ULD0BAV8M7RN"
   //name    = "mysql-dev.rdevopsb72.store"
  // type    = "A"
   //ttl     = 30
   //records = [aws_instance.mysql.private_ip]
 //}



   //           resource "aws_instance" "shipping" {
     //           ami           = data.aws_ami.centos.image_id
       //         instance_type = var.instance_type
         //       vpc_security_group_ids = [ data.aws_security_group.allow_all.id ]
           //     tags = {
             //     Name = "shipping"
               // }
              //}
 //resource "aws_route53_record" "shipping" {
   //zone_id = "Z03435932ULD0BAV8M7RN"
   //name    = "shipping-dev.rdevopsb72.store"
   //type    = "A"
   //ttl     = 30
   //records = [aws_instance.shipping.private_ip]
// }


  //            resource "aws_instance" "rabbitmq" {
    //            ami           = data.aws_ami.centos.image_id
      //          instance_type = var.instance_type
        //        vpc_security_group_ids = [ data.aws_security_group.allow_all.id ]
          //      tags = {
            //      Name = "rabbitmq"
              //  }
              //}
 //resource "aws_route53_record" "rabbitmq" {
   //zone_id = "Z03435932ULD0BAV8M7RN"
   //name    = "rabbitmq-dev.rdevopsb72.store"
   //type    = "A"
  // ttl     = 30
   //records = [aws_instance.rabbitmq.private_ip]
 //}

             //   resource "aws_instance" "payment" {
               //   ami           = data.aws_ami.centos.image_id
                 // instance_type = var.instance_type
                  //vpc_security_group_ids = [ data.aws_security_group.allow_all.id ]

                  //tags = {
                   // Name = "payment"
                  //}
                //}
 //resource "aws_route53_record" "payment" {
   //zone_id = "Z03435932ULD0BAV8M7RN"
   //name    = "payment-dev.rdevopsb72.store"
   //type    = "A"
   //ttl     = 30
   //records = [aws_instance.payment.private_ip]
 //}