#!/bin/bash

clear

# 检查是否已经安装 Docker 和 Docker Compose
if ! command -v docker >/dev/null || ! command -v docker-compose >/dev/null; then
    echo "请先安装 Docker 和 Docker Compose。"
    exit 1
fi

# 创建目录
mkdir -p /root/data/docker_data/qinglong-jdpro
cd /root/data/docker_data/qinglong-jdpro

# 从用户输入中获取容器端口
read -p "请输入容器端口: " PORT

#拉取镜像
docker pull nolanhzy/pro:latest

# 创建 docker-compose.yml 文件
cat > docker-compose.yml <<EOF
version: '3.9'
services:
    pro:
        image: 'nolanhzy/pro:latest'
        restart: always
        environment:
            - ServerProxy=#反代地址
            - Pwd=#密码
            - User=#用户
            - Prolic=#密钥
        volumes:
            - './data:/app/Data'
        ports:
            - '$PORT:5016'
        container_name: pro
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