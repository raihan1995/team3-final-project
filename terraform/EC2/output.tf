output "nginx_ip" {
  value = aws_instance.nginx-machine.public_ip[0]
}
output "eks_machine_output" {
  value = aws_instance.eks-machine.public_ip
}
