resource "aws_instance" "rebel_instance" {
    ami = data.aws_ami.rebel_ami.id
    instance_type = "t3.micro"
    subnet_id = data.aws_subnet.rebel_subnet.id
    vpc_security_group_ids = [ data.aws_security_group.rebel_sg.id ]
    tags = {
      Name = "Terraformer_VM"
    }   
}
