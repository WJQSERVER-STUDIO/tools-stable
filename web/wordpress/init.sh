#!/bin/bash

if [ ! -f /data/caddy/config/Caddyfile ]; then
    cp /data/caddy/Caddyfile /data/caddy/config/Caddyfile
fi

if [ ! -f /var/www/html/wordpress/index.php ]; then
    cp -r /var/www/html/wordpress.d/* /var/www/html/wordpress/
fi
if [ ! -f /data/caddy/config.d/wordpress ]; then
    cat > /data/caddy/config.d/wordpress <<EOF

$siteurl {
    root * /var/www/html/wordpress
    file_server
    php_fastcgi unix//run/php/php8.2-fpm.sock {
        import header_realip
    }
    import log wordpress
    import error_page
    import encode  
    import cache 0s 200s
}

EOF

fi

sed -i "s#{SQLITE_IMPLEMENTATION_FOLDER_PATH}#/var/www/html/wordpress/wp-content/mu-plugins#" /var/www/html/wordpress/wp-content/db.php 
sed -i 's#{SQLITE_PLUGIN}#sqlite-database-integration/load.php#' /var/www/html/wordpress/wp-content/db.php

chmod 755 -R /var/www/html/wordpress 
chmod 640 /var/www/html/wordpress/wp-content/database/.ht.sqlite 
chown www-data:www-data -R /var/www/html/wordpress

sqlite3 "/var/www/html/wordpress/wp-content/database/.ht.sqlite" <<EOF
UPDATE wp_options SET option_value = '$siteurl' WHERE option_name = 'siteurl';
UPDATE wp_options SET option_value = '$siteurl' WHERE option_name = 'home';
.quit
EOF


/usr/sbin/php-fpm8.2
/data/caddy/caddy run --config /data/caddy/config/Caddyfile

sqlite3 "/var/www/html/wordpress/wp-content/database/.ht.sqlite" <<EOF
UPDATE wp_options SET option_value = 'http://10.10.20.44:8080' WHERE option_name = 'siteurl';
UPDATE wp_options SET option_value = 'http://10.10.20.44:8080' WHERE option_name = 'home';
.quit
EOF