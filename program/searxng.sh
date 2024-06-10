#!/bin/bash

clear

# 检查是否已经安装 Docker 和 Docker Compose
if ! command -v docker >/dev/null || ! command -v docker-compose >/dev/null; then
    echo "请先安装 Docker 和 Docker Compose。"
    exit 1
fi

# 创建目录
mkdir -p /root/data/docker_data/searxng
cd /root/data/docker_data/searxng

# 从用户输入中获取容器端口
read -p "请输入容器端口: " PORT

# 创建 docker-compose.yml 文件
cat > docker-compose.yml <<EOF
version: '3.7'

services:
# caddy配置部分，按需使用
  #  caddy:
  #  container_name: caddy
  #  image: caddy:2-alpine
  #  network_mode: host
  #  volumes:
  #    - ./Caddyfile:/etc/caddy/Caddyfile:ro
  #    - caddy-data:/data:rw
  #    - caddy-config:/config:rw
  #  environment:
  #    - SEARXNG_HOSTNAME=${SEARXNG_HOSTNAME:-http://localhost:80}
  #    - SEARXNG_TLS=${LETSENCRYPT_EMAIL:-internal}
  #  cap_drop:
  #    - ALL
  #  cap_add:
  #    - NET_BIND_SERVICE
  #    - DAC_OVERRIDE

  redis:
    container_name: redis
    image: "redis:alpine"
    command: redis-server --save "" --appendonly "no"
    networks:
      - searxng
    tmpfs:
      - /var/lib/redis
    cap_drop:
      - ALL
    cap_add:
      - SETGID
      - SETUID
      - DAC_OVERRIDE

  searxng:
    container_name: searxng
    image: searxng/searxng:latest
    networks:
      - searxng
    ports:
     - "$PORT:8080"
    volumes:
      - ./searxng:/etc/searxng:rw
    environment:
      - SEARXNG_BASE_URL=https://${SEARXNG_HOSTNAME:-https://$URL}/
    cap_drop:
      - ALL
    cap_add:
      - CHOWN
      - SETGID
      - SETUID
      - DAC_OVERRIDE
    logging:
      driver: "json-file"
      options:
        max-size: "1m"
        max-file: "1"
networks:
  searxng:
    ipam:
      driver: default

        #volumes:
        #caddy-data:
        #caddy-config:
EOF

# 启动容器
docker-compose up -d

# 提示服务访问地址
echo "服务已成功启动！"
echo "请修改目录下的.env文件"
echo "默认目录/root/data/docker_data/searxng"

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
