#!/bin/bash

# 检查是否已经安装 Docker 和 Docker Compose
if ! command -v docker >/dev/null || ! command -v docker-compose >/dev/null; then
    echo "请先安装 Docker 和 Docker Compose。"
    exit 1
fi

# 创建数据存储目录
data_dir="/root/data/docker_data/uptime"
mkdir -p "$data_dir"

# 创建 Docker Compose 配置文件
cat > "$data_dir/docker-compose.yml" <<EOF
version: '3.8'
services:
  uptime-kuma:
    image: louislam/uptime-kuma
    volumes:
      - ./data:/app/data
    restart: always
    networks:
      hypernet:
        ipv4_address: 172.20.20.27

networks:
  hypernet:
    external: true    
EOF

# 切换到数据存储目录
cd "$data_dir" || exit

# 启动容器
docker-compose up -d

echo "Uptime Kuma 已成功启动！"

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
