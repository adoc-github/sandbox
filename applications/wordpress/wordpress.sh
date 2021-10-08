#!/usr/bin/env bash

echo "***************************************************************"
echo "For Debugging (print env. variables, define command tracing)"
echo "****************************************************************"
#set -o xtrace
#env
#set

# Update packages and Upgrade system
echo "****************************************************************"
echo "Updating System"
echo "****************************************************************"
apt-get update -y


echo "****************************************************************"
echo "Installing Apache"
echo "****************************************************************"
apt-get install apache2 apache2-utils -y
systemctl enable apache2
systemctl start apache2


echo "****************************************************************"
echo "Installing PHP Modules"
echo "****************************************************************"
apt-get install php7.2 php7.2-mysql libapache2-mod-php7.2 php7.2-cli php7.2-cgi php7.2-gd -y



echo "****************************************************************"
echo "Installing Wordpress"
echo "****************************************************************"
if ls $ARTIFACTS_PATH/wordpress*.tar.gz 1> /dev/null 2>&1; then
    cp $(find $ARTIFACTS_PATH -name 'wordpress*.tar.gz') ./wordpress.tar.gz >/dev/null
else
    wget -c http://wordpress.org/latest.tar.gz -O wordpress.tar.gz 
fi
tar -xzvf wordpress.tar.gz >/dev/null
rsync -av wordpress/* /var/www/html/ >/dev/null
chown -R www-data:www-data /var/www/html/ >/dev/null
chmod -R 755 /var/www/html/ >/dev/null
rm /var/www/html/index.html

echo "****************************************************************"
echo "Configuring database access"
echo "****************************************************************"
cd /var/www/html || exit
mv wp-config-sample.php wp-config.php

sed -i "s/database_name_here/$DB_NAME/g" wp-config.php
sed -i "s/username_here/$DB_USER/g" wp-config.php
sed -i "s/password_here/$DB_PASS/g" wp-config.php
sed -i "s/localhost/mysql.$DOMAIN_NAME/g" wp-config.php

#systemctl restart apache2.service


