data "aws_ami" "rebel_ami" {
  owners = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

data "aws_security_group" "rebel_sg" {
    filter {
      name = "tag:Name"
      values = [ "Terraformer_SG" ]
    }
}

data "aws_subnet" "rebel_subnet" {
    filter {
      name = "tag:Name"
      values = [ "My-Subnet-us-east-1c" ]
    }
  
}
