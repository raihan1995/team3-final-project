#!/bin/bash
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y unzip wget
wget https://releases.hashicorp.com/terraform/0.15.1/terraform_0.15.1_linux_amd64.zip
unzip terraform*.zip
sudo mv terraform /usr/local/bin
sudo rm terraform*.zip
terraform --version
