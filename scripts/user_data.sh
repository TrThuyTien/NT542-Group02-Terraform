#!/bin/bash

apt update -y
apt install -y apache2

echo "Lab Terraform" > /var/www/html/index.html

systemctl start apache2
systemctl enable apache2