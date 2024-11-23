#!/bin/bash

# 创建目录
mkdir -p /root/data/docker_data/qinglong
cd /root/data/docker_data/qinglong

# 清空屏幕
    clear

# 定义函数来执行选项1的操作
debian() {
    tag=debian
    echo "正在安装debian(镜像底层为debian-slim)青龙"
}

# 定义函数来执行选项2的操作
alpine() {
    tag=latest
    echo "正在安装latest-Alpine(镜像底层为alpine)青龙"
}

# 定义函数来执行选项3的操作
old() {
     tag=2.11.3
     echo "正在安装2.11.3版本青龙(特殊版本,供老版本脚本使用)"
}

{
    # 显示菜单
    echo "请选择青龙版本："
    echo "1. Debian(debian-slim)"
    echo "2. Alpine"
    echo "3. 2.11.3(供老脚本或对版本有要求的情况使用)"
    echo "4. 退出"

    # 读取用户输入
    echo -n "请输入选项对应的编号: "
    read choice

    # 根据用户输入执行相应的操作
    case $choice in
        1)
            debian
            ;;
        2)
            alpine
            ;;
        3)
            old
            ;;
        4)
            echo "再见！"
            exit
            ;;
        *)
            echo "使用默认TAG安装"
            tag=latest
            ;;
    esac
}

#进入目录
cd /root/data/docker_data/qinglong

# 创建 docker-compose.yml 文件
cat > docker-compose.yml <<EOF
version: '2'
services:
  web:
    image: whyour/qinglong:$tag  
    volumes:
      - ./data:/ql/data
    networks:
      hypernet:
        ipv4_address: 172.20.20.16
    environment:
      QlBaseUrl: '/'
    restart: unless-stopped

networks:
  hypernet:
    external: true        
EOF

# 启动容器
cd /root/data/docker_data/qinglong
docker-compose up -d

# 提示服务访问地址
echo "服务已成功启动！"
echo "请访问以下地址来访问您的服务："

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
