#!/bin/bash

echo "开始安装Docker"

# 安装 Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# 启动 Docker 服务
sudo systemctl start docker

# 添加当前用户到 docker 用户组
sudo usermod -aG docker $USER

# 安装 Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 验证 Docker 和 Docker Compose 安装
docker --version
docker-compose --version

#日志大小及IPV6设置
cat > /etc/docker/daemon.json <<EOF
{
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "16m",
        "max-file": "4"
    },
    "ipv6": true,
    "fixed-cidr-v6": "fd00:a380:a320:c0::/80",
    "experimental":true,
    "ip6tables":true
}
EOF

#创建子网
docker network create --subnet=172.20.0.0/16 --ipv6 --subnet=fd00:a380:a321:c0::/80 hypernet

#重启Docker
systemctl restart docker

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O docker-manager-menu.sh ${repo_url}docker-manager/docker-manager-menu.sh && chmod +x docker-manager-menu.sh && ./docker-manager-menu.sh
else
    echo "脚本结束"
fi
