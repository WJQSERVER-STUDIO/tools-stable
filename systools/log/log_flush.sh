#!/bin/bash
#fork by https://www.nodeseek.com/post-76866-1
sudo mkdir -p /var/log/journal && sudo systemctl restart systemd-journald && sudo journalctl --flush

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O log_menu.sh ${repo_url}systools/log/log_menu.sh && chmod +x log_menu.sh && ./log_menu.sh
else
    echo "脚本结束"
fi