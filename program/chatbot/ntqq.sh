#!/bin/bash

clear

# 检查是否已经安装 Docker 和 Docker Compose
if ! command -v docker >/dev/null || ! command -v docker-compose >/dev/null; then
    echo "请先安装 Docker 和 Docker Compose。"
    exit 1
fi

# 创建目录
mkdir -p /root/data/docker_data/ntqq
cd /root/data/docker_data/ntqq
# 从用户输入中获取容器端口
read -p "请输入容器连接端口: " LINKPORT

# 从用户输入中获取容器端口
read -p "请输入容器VNC端口: " VNCPORT

#拉取镜像
docker pull luomubiji/ntqq:latest

# 创建 docker-compose.yml 文件
cat > docker-compose.yml <<EOF
version: '3.9'
services:
    ntqq:
        image: 'luomubiji/ntqq:latest'
        ports:
            - '$LINKPORT:3000'
            - '$VNCPORT:5900'
        volumes:
            - './LLOneBot/:/opt/QQ/resources/app/LiteLoaderQQNT/data/LLOneBot/'
        container_name: NTQQ

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
    wget -O chatbot_menu.sh ${repo_url}program/chatbot/chatbot_menu.sh && chmod +x chatbot_menu.sh && ./chatbot_menu.sh
else
    echo "脚本结束"
fi