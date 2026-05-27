variable "ami_id" {
    type = string
}

variable "instance_type" {
  type = string
}

variable "security_group_id" {
  type = string
  default = ""
}

variable "subnet_id" {
  type = string
  default = ""
}

variable "key_name" {
  type = string
}

variable "instance_tags" {
  type = map(string)
}