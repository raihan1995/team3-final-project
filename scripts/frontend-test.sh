#!/bin/bash
sudo apt update -y
sudo apt install npm -y
sudo npm uninstall -g angular-cli @angular/cli e clean
sudo npm cache clean --force
echo n | sudo npm install -g @angular/cli@8.0.3
echo n | sudo npm install --save-dev @angular/cli@8.0.3
sudo npm install --save-dev @angular-devkit/build-angular@0.803.24
cd spring-petclinic-angular-master
echo n | npm install
sudo apt install chromium-browser
export CHROME_BIN='/usr/bin/chromium-browser'
ng test --watch false --browsers ChromeHeadless
