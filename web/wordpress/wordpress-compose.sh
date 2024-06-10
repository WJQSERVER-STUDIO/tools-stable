docker exec php apt update &&
docker exec php apt install -y apt install -y libmariadb-dev-compat libmariadb-dev libzip-dev libmagickwand-dev imagemagick libsqlite3-dev libpng-dev libjpeg-dev libfreetype6-dev libicu-dev &&
docker exec php docker-php-ext-install mysqli pdo_mysql zip exif gd intl bcmath opcache curl mbstring xml sqlite3 &&
docker exec php sh -c 'echo "memory_limit=256M" > /usr/local/etc/php/conf.d/memory.ini'