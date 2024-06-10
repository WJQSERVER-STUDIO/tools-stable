#!/bin/bash

# 检测脚本是否以 root 用户身份运行
if [[ $EUID -ne 0 ]]; then
   echo "错误：请使用 root 用户身份运行此脚本。"
   exit 1
fi

apt-get install -y syncthing

PUBLIC_IP=0.0.0.0
PORT=8384

cat > /etc/systemd/system/syncthing.service <<EOF
[Unit]
Description=Syncthing - Open Source Continuous File Synchronization
After=network.target

[Service]
ExecStart=/usr/bin/syncthing -no-browser
Restart=on-failure
User=root

[Install]
WantedBy=default.target

EOF

# 启动Syncthing服务
systemctl daemon-reload
CONFIG_FILE="/root/.config/syncthing/config.xml"
systemctl enable syncthing
systemctl start syncthing
sed -i "s|<address>.*</address>|<address>$PUBLIC_IP:$PORT</address>|" "$CONFIG_FILE"
systemctl restart syncthing

# 回到root目录
cd /root

# 导入配置文件
source repo_url.conf

# 等待3s
sleep 3

# 返回菜单/退出脚本
read -p "是否返回菜单？ [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O program-menu.sh "${repo_url}program/program-menu.sh" && chmod +x program-menu.sh && ./program-menu.sh
else
    echo "脚本结束"
fi