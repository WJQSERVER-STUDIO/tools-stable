#!/bin/bash

clear

# 创建目录
mkdir -p /root/data/ddns_go
cd /root/data/ddns_go

#下载
wget https://github.com/jeessy2/ddns-go/releases/latest/download/ddns-go_6.7.0_linux_x86_64.tar.gz

#解压
tar -xzvf ddns-go_6.7.0_linux_x86_64.tar.gz
rm ddns-go_6.7.0_linux_x86_64.tar.gz

#赋权
chmod +x /root/data/ddns_go/ddns-go

# 创建配置文件
touch /root/data/ddns_go/.ddns_go_config.yaml

# 创建服务文件
cat <<EOF > /etc/systemd/system/ddns-go.service
[Unit]
Description=DDNS GO
After=network.target

[Service]
ExecStart=/root/data/ddns_go/ddns-go -f 600 -c /root/data/ddns_go/.ddns_go_config.yaml -l :19877
WorkingDirectory=/root/data/ddns_go
Restart=always
User=root
Group=root

[Install]
WantedBy=multi-user.target
EOF

# 重新加载systemd服务
systemctl daemon-reload

# 启用服务
systemctl enable ddns-go.service

# 启动服务
systemctl start ddns-go.service

# 检查服务状态
systemctl status ddns-go.service

# 提示服务访问地址
echo "服务已成功启动！"
echo "请访问以下地址来访问您的服务："
echo "http://<服务器IP>:19877"

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O program-menu.sh ${repo_url}program/program-menu.sh && chmod +x program-menu.sh && ./program-menu.sh
else
    echo "脚本结束"
fi