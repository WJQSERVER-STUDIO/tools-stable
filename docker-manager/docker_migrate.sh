#!/bin/bash

read -p "此操作将执行危险操作，是否继续？(y/n): " confirm
if [[ $confirm != "y" ]]; then
    echo "操作已取消。"
    exit 0
fi

# 停止 Docker 服务
sudo systemctl stop docker

# 获取用户输入的目录路径
read -p "请输入新的 Docker 目录路径: " new_docker_path

# 创建新的 Docker 目录
sudo mkdir -p "$new_docker_path"

# 设置正确的权限
sudo chown -R $USER:$USER "$new_docker_path"

# 拷贝 Docker 目录到新位置
sudo cp -rp /var/lib/docker/* "$new_docker_path"

# 更新 Docker 配置文件
sudo sed -i "s|/var/lib/docker|$new_docker_path|g" /etc/docker/daemon.json

# 启动 Docker 服务
sudo systemctl start docker
