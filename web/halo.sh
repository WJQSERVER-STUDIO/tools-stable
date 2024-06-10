#!/bin/bash

# 检查是否已经安装 Docker 和 Docker Compose
if ! command -v docker >/dev/null || ! command -v docker-compose >/dev/null; then
    echo "请先安装 Docker 和 Docker Compose。"
    exit 1
fi

# 创建目录
mkdir -p /root/data/docker_data/halo
cd /root/data/docker_data/halo

#站点地址
read -p "请输入站点地址(例如https://example.com/): " WEBSITE_URL

# 创建 Docker Compose 配置文件
cat > docker-compose.yml <<EOF
version: "3"

services:
  halo:
    image: halohub/halo:2.16
    container_name: halo
    restart: on-failure:3
    depends_on:
      halodb:
        condition: service_healthy
    networks:
      hypernet:
        ipv4_address: 172.20.100.10
    volumes:
      - ./halo2:/root/.halo2
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8090/actuator/health/readiness"]
      interval: 30s
      timeout: 5s
      retries: 5
      start_period: 30s          
    command:
      - --spring.r2dbc.url=r2dbc:pool:postgresql://halodb/halo
      - --spring.r2dbc.username=halo
      # PostgreSQL 的密码，请保证与下方 POSTGRES_PASSWORD 的变量值一致。
      - --spring.r2dbc.password=openpostgresql
      - --spring.sql.init.platform=postgresql
      # 外部访问地址，请根据实际需要修改
      - --halo.external-url=$WEBSITE_URL
      - --halo.cache.page.disabled=false
  halodb:
    image: postgres:15.4
    container_name: halodb
    restart: always
    networks:
      hypernet:
        ipv4_address: 172.20.100.20
    volumes:
      - ./db:/var/lib/postgresql/data
    healthcheck:
      test: [ "CMD", "pg_isready" ]
      interval: 10s
      timeout: 5s
      retries: 5
    environment:
      - POSTGRES_PASSWORD=openpostgresql
      - POSTGRES_USER=halo
      - POSTGRES_DB=halo
      - PGUSER=halo

networks:
  hypernet:
    external: true

EOF

# 启动 HALO
docker-compose up -d

echo "Halo 已成功部署！"
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
    wget -O web-menu.sh ${repo_url}web/web-menu.sh && chmod +x web-menu.sh && ./web-menu.sh
else
    echo "脚本结束"
fi