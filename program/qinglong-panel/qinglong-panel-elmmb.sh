#!/bin/bash

clear

# 检查是否已经安装 Docker 和 Docker Compose
if ! command -v docker >/dev/null || ! command -v docker-compose >/dev/null; then
    echo "请先安装 Docker 和 Docker Compose。"
    exit 1
fi

# 创建目录
mkdir -p /root/data/docker_data/elmmb
cd /root/data/docker_data/elmmb

#拉取镜像
docker pull luobook/elmmb:latest

# 从用户输入中获取容器端口
read -p "请输入容器端口: " PORT

# 创建 docker-compose.yml 文件
cat > docker-compose.yml <<EOF
version: '3.9'
services:
    elmmb:
        image: 'luobook/elmmb:latest'
        restart: always
        privileged: true
        volumes:
            - './elmmb:/etc/lb/Config'
        ports:
            - '$PORT:3000'
        container_name: elmmb
        stdin_open: true

EOF

# 启动容器
docker-compose up -d

# 提示服务访问地址
echo "服务已成功启动！"
echo "请访问以下地址来访问您的服务："
echo "http://<服务器IP>:$PORT"

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O qinglong-panel.sh ${repo_url}program/qinglong-panel/qinglong-panel.sh && chmod +x qinglong-panel.sh && ./qinglong-panel.sh
else
    echo "脚本结束"
fi