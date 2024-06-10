#!/bin/bash

clear

# 检查是否已经安装 Docker 和 Docker Compose
if ! command -v docker >/dev/null || ! command -v docker-compose >/dev/null; then
    echo "请先安装 Docker 和 Docker Compose。"
    exit 1
fi

# 创建目录
mkdir -p /root/data/docker_data/vanblog
cd /root/data/docker_data/vanblog

# 创建 docker-compose.yml 文件
cat > docker-compose.yml <<EOF
version: '3'

services:
  vanblog:
    image: mereith/van-blog:latest
    restart: always
    environment:
      TZ: 'Asia/Shanghai'
    volumes:
      - ./data/static:/app/static
      - ./log:/var/log
      - ./caddy/config:/root/.config/caddy
      - ./caddy/data:/root/.local/share/caddy
    networks:
      hypernet:
        ipv4_address: 172.20.20.30      
  mongo:
    image: mongo:latest
    restart: always
    environment:
      TZ: 'Asia/Shanghai'
    volumes:
      - ./data/mongo:/data/db
    networks:
      hypernet:
        ipv4_address: 172.20.20.31

networks:
  hypernet:
    external: true
EOF

# 启动容器
docker-compose up -d

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
    echo "back2memu_changeme"
else
    echo "脚本结束"
fi