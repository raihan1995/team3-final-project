resource "aws_instance" "nginx-machine" {
  ami               = var.ami_id
  instance_type     = var.instance_type
  availability_zone = var.av_zone
  key_name          = var.key_name
  count             = 2
  network_interface {
    device_index         = 0
    network_interface_id = var.net_id
  }
}
resource "aws_instance" "eks-machine" { # Not sure we need this...
  ami               = var.ami_id        # If deleting, delete the corresponding output.
  instance_type     = var.instance_type
  availability_zone = var.av_zone
  key_name          = var.key_name
  network_interface {
    device_index         = 0
    network_interface_id = var.net_id
  }
}
