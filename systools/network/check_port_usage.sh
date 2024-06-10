#!/bin/bash

apt install lsof

# 提示用户输入端口号
read -p "请输入要查看的端口号: " port

# 检查TCP端口占用情况
tcp_result=$(sudo lsof -iTCP:$port -sTCP:LISTEN -n -P)

# 检查UDP端口占用情况
udp_result=$(sudo netstat -lnup | awk -v port="$port" '$1 ~ "udp" && $4 ~ ":'"$port"'"')

# 输出结果
if [[ -n "$tcp_result" ]]; then
  echo "占用TCP 端口 $port 的进程:"
  echo "$tcp_result"
else
  echo "TCP 端口 $port 未被占用."
fi

echo

if [[ -n "$udp_result" ]]; then
  echo "占用UDP 端口 $port 的进程:"
  echo "$udp_result"
else
  echo "UDP 端口 $port 未被占用."
fi

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O network_menu.sh ${repo_url}systools/network/network_menu.sh && chmod +x network_menu.sh && ./network_menu.sh
else
    echo "脚本结束"
fi