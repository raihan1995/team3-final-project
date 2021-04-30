#!/bin/bash
sudo apt install npm
npm uninstall -g angular-cli @angular/cli e clean
sudo npm cache clean
sudo npm install -g @angular/cli@latest
npm install --save-dev @angular/cli@latest
sudo apt install karma-tools
npm install --save-dev @angular-devkit/build-angular
cd spring-petclinic-angular-master
npm install
ng test