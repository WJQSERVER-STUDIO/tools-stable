#!/bin/bash

siteurl="https://example.com"

apt update
apt install php php-cgi php-fpm php-curl php-gd php-mbstring php-xml php-sqlite3 sqlite3 php-mysqli unzip sed wget curl vim git sudo tar zstd -y

mkdir -p /root/data/caddy/config 
wget -O /root/data/caddy/caddy.tar.gz https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/program/caddy/caddy.tar.gz 
tar -xzvf /root/data/caddy/caddy.tar.gz -C /root/data/caddy
rm /root/data/caddy/caddy.tar.gz
chmod +x /root/data/caddy/caddy
chown root:root /root/data/caddy/caddy

wget -q https://cn.wordpress.org/latest-zh_CN.zip
unzip -qq latest-zh_CN.zip -d /var/www/html/wordpress
mv /var/www/html/wordpress/wordpress/* /var/www/html/wordpress
rm -rf latest-zh_CN.zip /var/www/html/wordpress/wordpress

wget https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/web/wordpress/wp-config.php
mkdir -p /var/www/html/wordpress/wp-content/database
wget https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/web/wordpress/db.sqlite -P /var/www/html/wordpress/wp-content/database

mkdir -p /var/www/html/wordpress/wp-content/mu-plugins
wget https://downloads.wordpress.org/plugin/sqlite-database-integration.zip
unzip -qq sqlite-database-integration.zip -d /var/www/html/wordpress/wp-content/mu-plugins
rm -rf sqlite-database-integration.zip
cp /var/www/html/wordpress/wp-content/mu-plugins/db.copy /var/www/html/wordpress/wp-content/db.php
sed -i "s#{SQLITE_IMPLEMENTATION_FOLDER_PATH}#/var/www/html/wordpress/wp-content/mu-plugins#" /var/www/html/wordpress/wp-content/db.php
sed -i 's#{SQLITE_PLUGIN}#sqlite-database-integration/load.php#' /var/www/html/wordpress/wp-content/db.php

sqlite3 "/var/www/html/wordpress/wp-content/database/.ht.sqlite" <<EOF
UPDATE wp_options SET option_value = '$siteurl' WHERE option_name = 'siteurl';
UPDATE wp_options SET option_value = '$siteurl' WHERE option_name = 'home';
.quit
EOF

chmod 755 -R /var/www/html/wordpress
chmod 640 /var/www/html/wordpress/wp-content/database/.ht.sqlite
chown www-data:www-data -R /var/www/html/wordpress

cat > /root/data/caddy/config/wordpress <<EOF
$siteurl {
	root * /root/data/caddy/pages/demo
    php_fastcgi unix//run/php/php8.2-fpm.sock {
        import header_realip
    }
    file_server
    import log
    import error_page  
    import encode
}
EOF