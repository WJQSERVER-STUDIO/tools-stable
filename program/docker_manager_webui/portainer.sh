#!/bin/bash

# 创建目录
mkdir -p /root/data/docker_data/portainer
cd /root/data/docker_data/portainer

# 创建 docker-compose.yml 文件
cat > docker-compose.yml <<EOF
version: '3.9'
services:
    portainer-ce:
        image: '6053537/portainer-ce:latest'
        container_name: portainer
        restart: always
        volumes:
            - '/dockerData/portainer:/data'
            - '/var/run/docker.sock:/var/run/docker.sock'
        networks:
          hypernet:
            ipv4_address: 172.20.20.11

networks:
  hypernet:
    external: true
EOF

# 启动容器
docker-compose up -d

# 等待容器启动
sleep 5

# 获取容器ID
CONTAINER_ID=$(docker ps -q --filter ancestor=6053537/portainer-ce)

# 打印容器信息
docker ps -f id=$CONTAINER_ID

# 提示服务访问地址
echo "服务已成功启动！"

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 3

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O docker_manager_webui_menu.sh ${repo_url}program/docker_manager_webui/docker_manager_webui_menu.sh && chmod +x docker_manager_webui_menu.sh && ./docker_manager_webui_menu.sh
else
    echo "脚本结束"
fi
