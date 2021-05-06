output "subnet_id" {
  value = aws_subnet.public.id
}
output "server_public_ip" {
  value = aws_eip.one.public_ip
}
output "net_id" {
  value = aws_network_interface.foo.id
}
