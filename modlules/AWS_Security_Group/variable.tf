variable "security_group_name" {
  type = string
}

variable "security_group_description" {
  type = string
}

variable "vpc_id" {
  type = string
}

# Inbound Variables

variable "inbound_rules" {
    type = list(number)
}

variable "inbound_protocol" {
  type = string
}

variable "inbound_cidr_block" {
  type  = list(string)
}

variable "inbound_description" {
  type = string
}

# Outbound Variables

variable "outbound_rules" {
    type = list(number)
}

variable "outbound_protocol" {
  type = string
}

variable "outbound_cidr_block" {
  type  = list(string)
}

variable "outbound_description" {
  type = string
}