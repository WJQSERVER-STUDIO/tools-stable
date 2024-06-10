#!/bin/bash

clear

# 检查是否已经安装 Docker 和 Docker Compose
if ! command -v docker >/dev/null || ! command -v docker-compose >/dev/null; then
    echo "请先安装 Docker 和 Docker Compose。"
    exit 1
fi

# 创建目录
mkdir -p /root/data/docker_data/nginx
cd /root/data/docker_data/nginx

# 从用户输入中获取容器端口
read -p "请输入容器端口: " PORT

#拉取镜像
docker pull nginx:latest

# 创建 docker-compose.yml 文件
cat > docker-compose.yml <<EOF
version: '3.9'
services:
    nginx:
        image: 'nginx:latest'
        volumes:
            - './html:/usr/share/nginx/html'
            - './certs:/etc/nginx/certs'
            - './nginx.conf:/etc/nginx/nginx.conf'
        ports:
            - '443:443'
            - '80:80'
        container_name: nginx

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
    wget -O nginx_menu.sh ${repo_url}program/nginx/nginx_menu.sh && chmod +x nginx_menu.sh && ./nginx_menu.sh
else
    echo "脚本结束"
fi