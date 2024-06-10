#! /bin/bash
#https://github.com/WJQSERVER/tools-stable

clear

mkdir -p /root/data/caddy
mkdir -p /root/data/caddy/config
wget -O /root/data/caddy/caddy.tar.gz https://github.com/WJQSERVER/caddy/releases/download/2.8.4/caddy-linux-amd64-pages.tar.gz
tar -xzvf /root/data/caddy/caddy.tar.gz -C /root/data/caddy
rm /root/data/caddy/caddy.tar.gz
chmod +x /root/data/caddy/caddy
chown root:root /root/data/caddy/caddy
 
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

wget -O /root/data/caddy/Caddyfile https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/program/caddy/caddyfile

#./caddy add-package github.com/caddyserver/cache-handler
#./caddy add-package github.com/ueffel/caddy-brotli
#./caddy add-package github.com/caddyserver/transform-encoder
#./caddy add-package github.com/RussellLuo/caddy-ext/ratelimit
#./caddy add-package github.com/caddy-dns/cloudflare
chown root:root /root/data/caddy/Caddyfile
systemctl daemon-reload
systemctl enable caddy.service
systemctl start caddy.service
echo -e "[${green}OK${white}] $mikublue caddy安装完成" $white
