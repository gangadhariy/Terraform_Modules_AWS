# VPC variables

variable "atlas_core_vpc_cidrblock" {
  type = string
}

# Subnet variables

variable "atlas_core_subnet_cidrblock" {
  type = list(string)
}

variable "atlas_core_subnet_azs" {
  type = list(string)
}

# Security group variables
variable "atlas_core_sg_name" {
  type = string
}
variable "atlas_core_sg_inbound_ports" {
  type = list(object({
    port = number
    description = string
    cidr_block = list(string)
  }))
}

# Target Group Variables

variable "atlas_core_tg_name" {
  type = string
}

# Loadbalancer variables

variable "atlas_core_lb_name" {
  type = string
}

# Launch template variables

variable "atlas_core_lt_name" {
  type = string
}

variable "atlas_core_lt_ami_id" {
  type = string
}

# Auto-scaling group variables

variable "atlas_core_asg_azs" {
  type = list(string)
}