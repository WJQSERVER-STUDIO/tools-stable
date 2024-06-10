#!/bin/bash

# 检查是否已安装 Docker 和 Docker Compose
command -v docker >/dev/null 2>&1 || { echo >&2 "请先安装 Docker！"; exit 1; }
command -v docker-compose >/dev/null 2>&1 || { echo >&2 "请先安装 Docker Compose！"; exit 1; }

# 创建 WordPress 目录
mkdir wordpress && cd wordpress

# 获取用户输入的端口号
echo -n "请输入要映射的端口号（例如：8080）："
read port

# 创建 Docker Compose 配置文件
cat > docker-compose.yml <<EOF
version: '3'
services:
  db:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: your_mysql_root_password
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: your_mysql_password

  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    ports:
      - $port:80
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: your_mysql_password
volumes:
  db_data:
EOF

# 启动 WordPress
docker-compose up -d

echo "WordPress 已成功部署！"
#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O web-menu.sh ${repo_url}web/web-menu.sh && chmod +x web-menu.sh && ./web-menu.sh
else
    echo "脚本结束"
fi
