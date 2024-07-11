#! /bin/bash
#https://github.com/WJQSERVER－STUDIO/tools-stable

mikublue="\033[38;2;57;197;187m"
yellow='\033[33m'
white='\033[0m'
green='\033[0;32m'
blue='\033[0;34m'
red='\033[31m'
gray='\e[37m'

clear

echo -e "[${yellow}RUN${white}] $mikublue 開始安裝Caddy" $white

echo -e "${green}>${white} $mikublue 創建安裝目錄" $white
mkdir -p /root/data/caddy
mkdir -p /root/data/caddy/config
echo -e "${green}>${white} $mikublue 下載主程序" $white
wget -O /root/data/caddy/caddy.tar.gz https://github.com/WJQSERVER/caddy/releases/download/2.8.4/caddy-linux-amd64-pages.tar.gz
echo -e "${green}>${white} $mikublue 解壓程序及其資源" $white
tar -xzvf /root/data/caddy/caddy.tar.gz -C /root/data/caddy
echo -e "${green}>${white} $mikublue 清理安裝資源" $white
rm /root/data/caddy/caddy.tar.gz
echo -e "${green}>${white} $mikublue 設置程序運行權限" $white
chmod +x /root/data/caddy/caddy
chown root:root /root/data/caddy/caddy

echo -e "${green}>${white} $mikublue 創建SERVICE文件" $white

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

echo -e "${green}>${white} $mikublue 拉取Caddyfile配置" $white
wget -O /root/data/caddy/Caddyfile https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/program/caddy/caddyfile

#./caddy add-package github.com/caddyserver/cache-handler
#./caddy add-package github.com/ueffel/caddy-brotli
#./caddy add-package github.com/caddyserver/transform-encoder
#./caddy add-package github.com/RussellLuo/caddy-ext/ratelimit
#./caddy add-package github.com/caddy-dns/cloudflare
echo -e "${green}>${white} $mikublue 啟動程序" $white
systemctl daemon-reload
systemctl enable caddy.service
systemctl start caddy.service
echo -e "[${green}OK${white}] $mikublue caddy安装完成" $white
