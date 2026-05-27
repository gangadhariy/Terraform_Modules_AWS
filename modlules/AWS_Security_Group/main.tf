resource "aws_security_group" "main" {
    name        = var.security_group_name
    description = var.security_group_description
    vpc_id      = var.vpc_id
    dynamic "ingress" {
        for_each = var.inbound_rules
        content {
          from_port = ingress.value
          to_port = ingress.value
          protocol = var.inbound_protocol
          cidr_blocks = var.inbound_cidr_block
          description = var.inbound_description
        }
    }
    dynamic "egress" {
        for_each = var.outbound_rules
        content {
          from_port = egress.value
          to_port = egress.value
          protocol = var.outbound_protocol
          cidr_blocks = var.outbound_cidr_block
          description = var.outbound_description
        }
    }    
}