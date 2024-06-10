#!/bin/bash

if [[ -f "/etc/os-release" ]]; then
    source /etc/os-release
    distribution=$NAME
    version=$VERSION_ID

    if [[ $distribution == "Debian GNU/Linux" && $version == "12"* ]]; then
        echo "Debian12 Pass"
    else
        echo "ERROR"
        exit 1
    fi
else
    echo "ERROR"
    exit 1
fi

repo_url="https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/"

ROOT=/var/www/html/wordpress
mkdir -p $ROOT
cd $ROOT

read -p "请输入网站地址(错误输入会导致网访问出现问题):" siteurl

apt install sqlite3 unzip -y
apt install php php-cgi php-fpm php-curl php-gd php-mbstring php-xml php-sqlite3 sqlite3 php-mysqli unzip sed -y
wget -O /var/www/html/wordpress/latest-zh_CN.zip https://cn.wordpress.org/latest-zh_CN.zip
unzip /var/www/html/wordpress/latest-zh_CN.zip -d /var/www/html/wordpress
mv /var/www/html/wordpress/wordpress/* /var/www/html/wordpress
rm -rf latest-zh_CN.zip
rm -rf wordpress
wget ${repo_url}web/wordpress/wp-config.php

# 下载完整SQLite数据库
# 默认账号admin 默认密码pass
mkdir -p $ROOT/wp-content/database
cd $ROOT/wp-content/database
wget ${repo_url}web/wordpress/db.sqlite
mv db.sqlite .ht.sqlite

#下载官方插件
cd $ROOT/wp-content
mkdir -p mu-plugins
cd mu-plugins
wget https://downloads.wordpress.org/plugin/sqlite-database-integration.zip
unzip -qq sqlite-database-integration.zip
rm -rf sqlite-database-integration.zip

PLUGIN_DIR="$ROOT/wp-content/mu-plugins/sqlite-database-integration"

cp $PLUGIN_DIR/db.copy $ROOT/wp-content/db.php
sed -i "s#{SQLITE_IMPLEMENTATION_FOLDER_PATH}#$PLUGIN_DIR#" $ROOT/wp-content/db.php
sed -i 's#{SQLITE_PLUGIN}#sqlite-database-integration/load.php#' $ROOT/wp-content/db.php

sqlite3 "$ROOT/wp-content/database/.ht.sqlite" <<EOF
UPDATE wp_options SET option_value = '$siteurl' WHERE option_name = 'siteurl';
.quit
EOF

sqlite3 "$ROOT/wp-content/database/.ht.sqlite" <<EOF
UPDATE wp_options SET option_value = '$siteurl' WHERE option_name = 'home';
.quit
EOF

chmod 755 -R $ROOT
chmod 640 $ROOT/wp-content/database/.ht.sqlite
chown www-data:www-data -R $ROOT