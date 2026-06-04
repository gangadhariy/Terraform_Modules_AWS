# Vpc Variables

atlas_core_vpc_cidrblock = "10.2.0.0/16"

# Subnet Variables

atlas_core_subnet_cidrblock = [ "10.2.1.0/24" , "10.2.2.0/24" ]
atlas_core_subnet_azs = [ "us-east-1a","us-east-1b","us-east-1c" ]


# Security Group Variables

atlas_core_sg_name = "atlas_core_prod_sg"

atlas_core_sg_inbound_ports = [
  {
    port = 80
    description = "Allow HTTP access"
    cidr_block = ["0.0.0.0/0"]
  },
  {
    port = 22
    description = "Allow SSH access"
    cidr_block = ["0.0.0.0/0"]
  }
]

# Target Group Variables

atlas_core_tg_name = "atlas-core-prod-tg"

# Load balancer variables

atlas_core_lb_name = "atlas-core-prod-lb"

# Launch template variables
atlas_core_lt_name = "atlas-prod-lt"

atlas_core_lt_ami_id = "ami-091138d0f0d41ff90"

# Auto-scaling group variables

atlas_core_asg_azs = [ "us-east-1a","us-east-1b","us-east-1c" ]
