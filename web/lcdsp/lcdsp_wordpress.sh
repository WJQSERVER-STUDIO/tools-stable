#!/bin/bash

if [[ -f "/etc/os-release" ]]; then
    source /etc/os-release
    distribution=$NAME
    version=$VERSION_ID

    if [[ $distribution == "Debian GNU/Linux" ]]; then
        echo "Debian Pass"
    else
        echo "ERROR Not Debian"
        exit 1
    fi
fi

read -p "请输入网站地址(错误输入会导致网访问出现问题):" siteurl

apt update
apt install sqlite3 unzip wget curl sudo -y

mkdir -p /var/www/html/wordpress

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo systemctl start docker
sudo usermod -aG docker $USER
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker --version
docker-compose --version

cat > /etc/docker/daemon.json <<EOF
{
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "16m",
        "max-file": "4"
    },
    "ipv6": true,
    "fixed-cidr-v6": "fd00:a380:a320:c0::/80",
    "experimental":true,
    "ip6tables":true
}
EOF

systemctl restart docker
sleep 3
docker network create --subnet=172.20.0.0/16 --ipv6 --subnet=fd00:a380:a321:c0::/80 hypernet

wget -O /var/www/docker-compose.yml https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/web/lcdsp/wordpress/docker-compose.yml
cd /var/www && docker-compose up -d

docker exec php apt update &&
docker exec php apt install -y libmariadb-dev-compat libmariadb-dev libzip-dev libmagickwand-dev imagemagick libsqlite3-dev libpng-dev libjpeg-dev libfreetype6-dev libicu-dev &&
docker exec php docker-php-ext-install mysqli pdo_mysql zip exif gd intl bcmath opcache curl mbstring xml sqlite3 &&
docker exec php sh -c 'echo "memory_limit=256M" > /usr/local/etc/php/conf.d/memory.ini'

wget -O /var/www/html/wordpress/latest-zh_CN.zip https://cn.wordpress.org/latest-zh_CN.zip
unzip /var/www/html/wordpress/latest-zh_CN.zip -d /var/www/html/wordpress
mv /var/www/html/wordpress/wordpress/* /var/www/html/wordpress
rm -rf /var/www/html/wordpress/wordpress
rm -rf /var/www/html/wordpress/latest-zh_CN.zip 

# 下载 wp-config.php 和数据库文件
wget -O /var/www/html/wordpress/wp-config.php https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/web/wordpress/wp-config.php 
mkdir -p /var/www/html/wordpress/wp-content/database 
wget https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/web/wordpress/db.sqlite -P /var/www/html/wordpress/wp-content/database
mv /var/www/html/wordpress/wp-content/database/db.sqlite /var/www/html/wordpress/wp-content/database/.ht.sqlite

# 安装 SQLite 插件
mkdir -p /var/www/html/wordpress/wp-content/mu-plugins 
wget -O /var/www/html/wordpress/wp-content/sqlite-database-integration.zip https://downloads.wordpress.org/plugin/sqlite-database-integration.zip 
unzip /var/www/html/wordpress/wp-content/sqlite-database-integration.zip -d /var/www/html/wordpress/wp-content/mu-plugins 
rm -rf /var/www/html/wordpress/wp-content/sqlite-database-integration.zip 
cp /var/www/html/wordpress/wp-content/mu-plugins/sqlite-database-integration/db.copy /var/www/html/wordpress/wp-content/db.php 

sed -i "s#{SQLITE_IMPLEMENTATION_FOLDER_PATH}#/var/www/html/wordpress/wp-content/mu-plugins#" /var/www/html/wordpress/wp-content/db.php 
sed -i 's#{SQLITE_PLUGIN}#sqlite-database-integration/load.php#' /var/www/html/wordpress/wp-content/db.php

chmod 755 -R /var/www/html/wordpress
chmod 750 /var/www/html/wordpress/wp-content/database/.ht.sqlite 
chown www-data:www-data -R /var/www/html/wordpress

sqlite3 "/var/www/html/wordpress/wp-content/database/.ht.sqlite" <<EOF
UPDATE wp_options SET option_value = '$siteurl' WHERE option_name = 'siteurl';
UPDATE wp_options SET option_value = '$siteurl' WHERE option_name = 'home';
.quit

EOF

sqlite3 "/var/www/html/wordpress/wp-content/database/.ht.sqlite" <<EOF
UPDATE wp_options SET option_value = 'http://10.10.20.44:8080' WHERE option_name = 'siteurl';
UPDATE wp_options SET option_value = 'http://10.10.20.44:8080' WHERE option_name = 'home';
.quit

EOF

cat > /var/www/caddy/config.d/wordpress <<EOF

$siteurl {
	root * /root/data/caddy/pages/demo
    php_fastcgi php:9000 {
        import header_realip
    }
    file_server
    import log
    import error_page  
    import encode
}

EOF

cd /var/www && docker-compose restart

echo "部署完成"