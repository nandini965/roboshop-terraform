
resource "aws_instance" "instance" {
  ami           = "data.aws_ami.centos.image_id"
  instance_type = var.instance_type
  vpc_security_group_ids = ["data.aws_security_group.allow-all.id"]

  tags = {
    Name = var.component_name
  }
}
resource "null_resource" "provisioner" {
  depend_on = [aws_instance, aws_route53_record.record]
  instance_type = var.instance_type
  provisioner "remote-exec" {

    connection {
      type = "ssh"
      user = "centos"
      password = "DevOps321"
      host     = aws_instance.instance.private_ip
    }
    inline = [
      "rm -rf roboshop-shell",
      "git clone https://github.com/nandini965/roboshop-shell.git",
      "cd roboshop-shell",
      "sudo bash ${component_name.sh} ${var.password}"
    ]
  }
}
resource "aws_route53_record" "records" {
  zone_id = "Z06687951N51EPJX2EZYT"
  name    = "${var.component_name}-dev.rdevopsb72.store"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}
