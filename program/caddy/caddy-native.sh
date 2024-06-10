#!/bin/bash

clear

# 创建目录
mkdir -p /root/data/caddy
cd /root/data/caddy

#下载
wget https://github.com/caddyserver/caddy/releases/latest/download/caddy_2.7.6_linux_amd64.tar.gz

#解压
tar -xzvf caddy_2.7.6_linux_amd64.tar.gz
rm caddy_2.7.6_linux_amd64.tar.gz

#赋权
chmod +x /root/data/caddy/caddy
chown root:root /root/data/caddy/caddy

# 创建服务文件
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

#创建hello world
mkdir -p /root/data/caddy/page
cat <<EOF > /root/data/caddy/page/index.html
<html>
 <head>
 </head>
 <body>
   <h1> Hello World </h1>
   <h2> Hello World </h2>
   <h3> Hello World </h3>
   <h4> Hello World </h4>
   <h5> Hello World </h5>
   <h6> Hello World </h6>
 </body>
</html>

EOF

#创建caddyfile
cat <<EOF > /root/data/caddy/Caddyfile
{
    debug
    http_port 80
    https_port 443
}

:80 {
	root * /root/data/caddy/page
	try_files {path}/index.html
     file_server
}
EOF

#赋权
chown root:root /root/data/caddy/Caddyfile

# 重新加载systemd服务
systemctl daemon-reload

# 启用服务
systemctl enable caddy.service

# 启动服务
systemctl start caddy.service

# 检查服务状态
systemctl status caddy.service

# 提示服务访问地址
echo "服务已成功启动！"
echo "采用Caddyfile配置文件"
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