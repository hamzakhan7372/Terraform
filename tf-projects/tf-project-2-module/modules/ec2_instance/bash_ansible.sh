#!/bin/bash
#installing ansible
sudo apt update -y
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
sudo apt install unzip zip tar -y
sudo apt install apache2 -y
sudo systemctl restart apache2 -y
sudo systemctl enable apache2
