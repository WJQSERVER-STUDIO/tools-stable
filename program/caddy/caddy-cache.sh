#!/bin/bash

clear

echo 开始安装Caddy2

mkdir -p /root/data/caddy >> /root/data/log/aek971.log 2>&1
mkdir -p /root/data/caddy/config >> /root/data/log/aek971.log 2>&1
wget -O /root/data/caddy/caddy.tar.gz https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/program/caddy/caddy.tar.gz >> /root/data/log/aek971.log 2>&1
tar -xzvf /root/data/caddy/caddy.tar.gz -C /root/data/caddy >> /root/data/log/aek971.log 2>&1
rm /root/data/caddy/caddy.tar.gz >> /root/data/log/aek971.log 2>&1
chmod +x /root/data/caddy/caddy >> /root/data/log/aek971.log 2>&1
chown root:root /root/data/caddy/caddy >> /root/data/log/aek971.log 2>&1
 
cat <<EOF > /etc/systemd/system/caddy.service
[Unit]
Description=Caddy
Documentation=https://caddyserver.com/docs/
After=network.target network-online.target
Requires=network-online.target

[Service]
Type=notify
User=root
Group=root
ExecStart=/root/data/caddy/caddy run --environ --config /root/data/caddy/Caddyfile
ExecReload=/root/data/caddy/caddy reload --config /root/data/caddy/Caddyfile --force
WorkingDirectory=/root/data/caddy
TimeoutStopSec=5s
LimitNOFILE=1048576
PrivateTmp=true
ProtectSystem=full
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target

EOF

wget -O /root/data/caddy/Caddyfile https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/program/caddy/caddyfile >> /root/data/log/aek971.log 2>&1

#./caddy add-package github.com/caddyserver/cache-handler
#./caddy add-package github.com/ueffel/caddy-brotli
#./caddy add-package github.com/caddyserver/transform-encoder
#./caddy add-package github.com/RussellLuo/caddy-ext/ratelimit
#./caddy add-package github.com/caddy-dns/cloudflare
chown root:root /root/data/caddy/Caddyfile >> /root/data/log/aek971.log 2>&1
systemctl daemon-reload >> /root/data/log/aek971.log 2>&1
systemctl enable caddy.service >> /root/data/log/aek971.log 2>&1
systemctl start caddy.service >> /root/data/log/aek971.log 2>&1
echo -e "[${green}OK${white}] $mikublue Caddy2安装完成" $white
echo "服务已成功启动！"
echo "默认采用Caddyfile配置"
echo "/root/data/caddy/Caddyfile"
echo "已在<服务器IP>:80上部署了演示页"

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