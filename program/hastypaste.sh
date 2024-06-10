#!/bin/bash

clear

# 检查是否已经安装 Docker 和 Docker Compose
if ! command -v docker >/dev/null || ! command -v docker-compose >/dev/null; then
    echo "请先安装 Docker 和 Docker Compose。"
    exit 1
fi

# 创建目录
mkdir -p /root/data/docker_data/hastypaste
cd /root/data/docker_data/hastypaste

# 从用户输入中获取容器端口
read -p "请输入容器端口: " PORT

# 创建 docker-compose.yml 文件
cat > docker-compose.yml <<EOF
version: "3"

services:
  paste-bin:
    image: ghcr.io/enchant97/hasty-paste:latest
    container_name: hasty-paste
    restart: unless-stopped
    ports:
      - $PORT:8000 # 左边的8090可以自行修改成服务器上没有使用的端口
    volumes:
      - ./data:/app/data
EOF

# 启动容器
docker-compose up -d

# 提示服务访问地址
echo "服务已成功启动！"
echo "请访问以下地址来访问您的服务："
echo "http:/<服务器IP>:$PORT"

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 3

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O program-menu.sh ${repo_url}program/program-menu.sh && chmod +x program-menu.sh && ./program-menu.sh
else
    echo "脚本结束"
fi
