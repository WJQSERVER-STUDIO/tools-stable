#!/bin/bash

# 设置目录变量
data_dir="/root/data/docker_data/npm/data"
letsencrypt_dir="/root/data/docker_data/npm/letsencrypt"

# 创建目录
echo "正在创建目录..."
mkdir -p "$data_dir"
mkdir -p "$letsencrypt_dir"

# 创建 Docker Compose 配置文件
cat > docker-compose.yml <<EOF
version: '3'
services:
  app:
    image: 'chishin/nginx-proxy-manager-zh:release'
    restart: always
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    volumes:
      - $data_dir:/data
      - $letsencrypt_dir:/etc/letsencrypt
EOF      

# 启动 Nginx Proxy Manager
echo "正在启动 Nginx Proxy Manager..."
docker-compose -f /root/data/docker_data/npm/docker-compose.yml up -d

echo "Nginx Proxy Manager 已成功部署！"
echo "面板服務已開啟在 http://<服务器IP>:81 "

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 3

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O nginx_menu.sh ${repo_url}program/nginx/nginx_menu.sh && chmod +x nginx_menu.sh && ./nginx_menu.sh
else
    echo "脚本结束"
fi
