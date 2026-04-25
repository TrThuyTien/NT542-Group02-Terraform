#!/bin/bash
set -e

efs_dns="${efs_dns}"

apt update -y

# Cài NFS client
apt install -y nfs-common

# Tạo thư mục mount
mkdir -p /var/www/html

# Mount EFS tạm thời
mount -t nfs4 -o nfsvers=4.1 ${efs_dns}:/ /var/www/html

# Thêm mount vĩnh viễn vào fstab
echo "${efs_dns}:/ /var/www/html nfs4 defaults,_netdev 0 0" >> /etc/fstab

# Kiểm tra mount
df -T -h

apt update -y
# Cài Apache + PHP
apt install -y apache2 \
php php-mysql libapache2-mod-php php-cli php-cgi \
php-gd php-mbstring php-xml php-intl php-zip php-curl php-imagick \
wget

systemctl enable apache2
systemctl start apache2

# Download WordPress
cd /tmp
wget https://wordpress.org/latest.tar.gz

# Giải nén trực tiếp vào EFS
tar xzvf latest.tar.gz
cp -r wordpress/* /var/www/html/

# Permission
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

systemctl restart apache2