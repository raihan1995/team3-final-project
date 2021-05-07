output "subnet_id_a" {
  value = aws_subnet.public_a.id
}
output "subnet_id_b" {
  value = aws_subnet.public_b.id
}
output "server_public_ip" {
  value = aws_eip.one.public_ip
}
output "net_id" {
  value = aws_network_interface.ENI_A.id
}
