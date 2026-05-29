output "vpc_id" {
  value = aws_vpc.atlas_core_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.atlas_core_subnet[*].id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.atlas_core_internet_gateway.id
}

output "route_table_id" {
  value = aws_route_table.atlas_core_rt[*].id
}

output "target_group_id" {
  value = aws_lb_target_group.atlas_core_target_group.id
}

output "loadbalancer_id" {
  value = aws_lb.atlas_core_lb.id
}

output "launch_template_id" {
  value = aws_launch_template.atlas_core_lt.id
}

output "autoscaling_group_id" {
  value = aws_autoscaling_group.atlas_core_asg.id
}