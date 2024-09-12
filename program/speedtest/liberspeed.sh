#!/bin/bash

#自定义端口
read -p "请输入容器端口: " PORT

# 输出使用的端口
echo "正在使用端口: $PORT"

# 创建目录
mkdir -p /root/data/docker_data/liberspeed
cd /root/data/docker_data/liberspeed

# 创建 docker-compose.yml 文件
cat > docker-compose.yml <<EOF
version: "2"
services:
  speedtest:
    image: adolfintel/speedtest
    container_name: speedtest
    ports:
      - $PORT:80
    restart: unless-stopped
EOF

# 启动容器
docker compose up -d

# 等待容器启动
sleep 5

# 获取容器ID
CONTAINER_ID=$(docker ps -q --filter ancestor=adolfintel/speedtest)

# 打印容器信息
docker ps -f id=$CONTAINER_ID

# 提示服务访问地址
echo "服务已成功启动！"
echo "请访问以下地址来访问您的服务："
echo "http://localhost:$PORT"

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
