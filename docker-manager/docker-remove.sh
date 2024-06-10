#!/bin/bash

# 停止所有正在运行的Docker容器
sudo docker stop $(sudo docker ps -aq)

# 删除所有Docker容器
sudo docker rm $(sudo docker ps -aq)

# 卸载Docker引擎
sudo apt-get purge docker-ce docker-ce-cli containerd.io

# 删除Docker相关配置文件和目录
sudo rm -rf /var/lib/docker
sudo rm -rf /etc/docker

# 删除Docker用户组
sudo groupdel docker

# 卸载Docker Compose
sudo rm /usr/local/bin/docker-compose

echo "Docker和Docker Compose已成功卸载。"