resource "aws_instance" "First_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ var.security_group_id ]
  subnet_id = var.subnet_id
  key_name = var.key_name
  tags = var.instance_tags
}