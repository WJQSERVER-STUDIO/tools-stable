#!/bin/bash

clear

# 检查是否已经安装 Docker 和 Docker Compose
if ! command -v docker >/dev/null || ! command -v docker-compose >/dev/null; then
    echo "请先安装 Docker 和 Docker Compose。"
    exit 1
fi

# 创建目录
mkdir -p /root/data/docker_data/dockge
cd /root/data/docker_data/dockge

# 创建 docker-compose.yml 文件
cat > docker-compose.yml <<EOF
version: "3.8"
services:
  dockge:
    image: louislam/dockge:1
    restart: unless-stopped
    networks:
      hypernet:
        ipv4_address: 172.20.20.10
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./data:/app/data
      - /root/data/docker_data:/root/data/docker_data
    environment:
      - DOCKGE_STACKS_DIR=/root/data/docker_data
      
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
    wget -O docker_manager_webui_menu.sh ${repo_url}program/docker_manager_webui/docker_manager_webui_menu.sh && chmod +x docker_manager_webui_menu.sh && ./docker_manager_webui_menu.sh
else
    echo "脚本结束"
fi