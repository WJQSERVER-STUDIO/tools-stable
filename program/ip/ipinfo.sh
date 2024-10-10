#!/bin/bash

clear

# 检查是否已经安装 Docker 和 Docker Compose
if ! command -v docker >/dev/null || ! command -v docker-compose >/dev/null; then
    echo "请先安装 Docker 和 Docker Compose。"
    exit 1
fi

# 创建目录
mkdir -p /root/data/docker_data/ip
cd /root/data/docker_data/ip

# 创建 docker-compose.yml 文件
cat > docker-compose.yml <<EOF
version: '3.9'
services:
    ip:
        image: 'wjqserver/ip:latest'
        restart: always
        volumes:
            - './ip/log/run:/data/ip/log'
            - './ip/log/caddy:/data/caddy/log'
            - './ip/db:/data/ip/db'
        networks:
          hypernet:
            ipv4_address: 172.20.20.34

networks:
  hypernet:
    external: true

EOF

# 启动容器
docker compose up -d

# 提示服务访问地址
echo "服务已成功启动！"

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O ip_menu.sh ${repo_url}program/ip/ip_menu.sh && chmod +x ip_menu.sh && ./ip_menu.sh
else
    echo "脚本结束"
fi