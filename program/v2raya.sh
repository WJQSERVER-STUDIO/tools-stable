#!/bin/bash

clear

# 检查是否已经安装 Docker 和 Docker Compose
if ! command -v docker >/dev/null || ! command -v docker-compose >/dev/null; then
    echo "请先安装 Docker 和 Docker Compose。"
    exit 1
fi

mkdir -p /root/data/docker_data/v2raya
cd /root/data/docker_data/v2raya

# 
xray() {
    tag=xray
    echo "使用xray内核"
}

#
v2ray() {
    tag=v2ray
    echo "使用v2ray内核"
}

{
    # 显示菜单
    echo "请选择内核版本:"
    echo "1. Xray"
    echo "2. V2ray"

    # 读取用户输入
    echo -n "请输入选项对应的编号: "
    read choice

    # 根据用户输入执行相应的操作
    case $choice in
        1)
            xray
            ;;
        2)
            v2ray
            ;;
        0)
            exit
            ;;
        *)
            echo "默认使用Xray内核"
            tag=xray
            ;;
    esac
}

# 创建 docker-compose.yml 文件
cat > docker-compose.yml <<EOF
version: '3.9'
services:
    v2raya:
        image: mzz2017/v2raya
        volumes:
            - '/etc/v2raya:/etc/v2raya'
            - '/etc/resolv.conf:/etc/resolv.conf'
            - '/lib/modules:/lib/modules:ro'
        environment:
            - IPTABLES_MODE=legacy
            - V2RAYA_NFTABLES_SUPPORT=off
            - V2RAYA_V2RAY_BIN=/usr/local/bin/$tag
            - V2RAYA_LOG_FILE=/tmp/v2raya.log
        container_name: v2raya
        network_mode: host
        privileged: true
        restart: always

EOF

# 启动容器
docker-compose up -d

# 提示服务访问地址
echo "服务已成功启动！"
echo "请访问以下地址来访问您的服务："
echo "http://<服务器IP>:2017"

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