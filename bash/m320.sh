#! /bin/bash
#Advanced Experimental Kit (Code971) By WJQSERVER-STUDIO_WJQSERVER
#https://github.com/WJQSERVER/tools-stable

mikublue="\033[38;2;57;197;187m"
yellow='\033[33m'
white='\033[0m'
green='\033[0;32m'
blue='\033[0;34m'
red='\033[31m'
gray='\e[37m'
mkdir -p /root/data/log

if [[ $EUID -ne 0 ]]; then
    echo "需要root权限"
    echo "即将返回主脚本"
    sleep 2s
    wget -O tools-stable.sh https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/tools-stable.sh && chmod +x tools-stable.sh && clear && ./tools-stable.sh
fi

if [[ -f "/etc/os-release" ]]; then
    source /etc/os-release
    distribution=$NAME
    version=$VERSION_ID

    if [[ $distribution == "Debian GNU/Linux" ]]; then
        echo "Debian Pass"
    else
        echo "ERROR"
        exit 1
    fi
else
    echo "ERROR"
    exit 1
fi

read -p "请输入SSH端口(请确保输入正确以开启UFW防火墙): " PORT

echo "脚本开始执行"
sleep 1s
clear
echo "**************************************************************************"
apt update >> /root/data/log/m320.log 2>&1
echo -e "[${green}OK${white}] $mikublue 1/11 更新软件源" $white
apt install wget curl vim git sudo tar -y >> /root/data/log/m320.log 2>&1
echo -e "[${green}OK${white}] $mikublue 2/11 安装常用组件" $white
apt upgrade -y >> /root/data/log/m320.log 2>&1
echo -e "[${green}OK${white}] $mikublue 3/11 更新系统组件包" $white
cp /etc/resolv.conf /etc/resolv.conf.bak >> /root/data/log/m320.log 2>&1

cat > /etc/resolv.conf <<EOF
nameserver 8.8.8.8
nameserver 1.1.1.1
nameserver 2001:4860:4860::8888
nameserver 2606:4700:4700::1111
EOF

echo -e "[${green}OK${white}] $mikublue 4/11 备份dns并更换dns为通用公共dns" $white

echo "**************************************************************************"

echo -e "[${red}Fail${white}] $mikublue 5/11 docker安装跳过" $white

echo "**************************************************************************"

mkdir -p /root/data/caddy >> /root/data/log/m320.log 2>&1
mkdir -p /root/data/caddy/config >> /root/data/log/m320.log 2>&1
wget -O /root/data/caddy/caddy.tar.gz https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/program/caddy/caddy.tar.gz >> /root/data/log/m320.log 2>&1
tar -xzvf /root/data/caddy/caddy.tar.gz -C /root/data/caddy >> /root/data/log/m320.log 2>&1
rm /root/data/caddy/caddy.tar.gz >> /root/data/log/m320.log 2>&1
chmod +x /root/data/caddy/caddy >> /root/data/log/m320.log 2>&1
chown root:root /root/data/caddy/caddy >> /root/data/log/m320.log 2>&1
 
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

wget -O /root/data/caddy/Caddyfile https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/program/caddy/caddyfile >> /root/data/log/m320.log 2>&1

#./caddy add-package github.com/caddyserver/cache-handler
#./caddy add-package github.com/ueffel/caddy-brotli
#./caddy add-package github.com/caddyserver/transform-encoder
#./caddy add-package github.com/RussellLuo/caddy-ext/ratelimit
#./caddy add-package github.com/caddy-dns/cloudflare
chown root:root /root/data/caddy/Caddyfile >> /root/data/log/m320.log 2>&1
systemctl daemon-reload >> /root/data/log/m320.log 2>&1
systemctl enable caddy.service >> /root/data/log/m320.log 2>&1
systemctl start caddy.service >> /root/data/log/m320.log 2>&1
echo -e "[${green}OK${white}] $mikublue 6/11 caddy安装完成" $white
echo -e "[${red}Fail${white}] $mikublue 7/11 dockge安装失败(开启于9000端口)" $white
echo -e "[${red}Fail${white}] $mikublue 8/11 Speedtest-X安装失败(开启于9001端口)" $white

echo "**************************************************************************"

sudo apt-get update >> /root/data/log/m320.log 2>&1
sudo apt-get install ufw -y >> /root/data/log/m320.log 2>&1
sudo ufw default deny incoming >> /root/data/log/m320.log 2>&1
sudo ufw default allow outgoing >> /root/data/log/m320.log 2>&1
sudo ufw allow $PORT >> /root/data/log/m320.log 2>&1
sudo ufw allow 80 >> /root/data/log/m320.log 2>&1
sudo ufw allow 443  >> /root/data/log/m320.log 2>&1
sudo ufw deny from 162.142.125.0/24 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 167.94.138.0/24 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 167.94.145.0/24 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 167.94.146.0/24 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 167.248.133.0/24 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 199.45.154.0/24 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 199.45.155.0/24 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 206.168.35.0/24 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 206.168.34.0/24 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 206.168.33.0/24 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 206.168.32.0/24 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 2602:80d:1000::/48 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 2602:80d:1001::/48 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 2602:80d:1002::/48 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 2602:80d:1003::/48 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 2602:80d:1004::/48 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 2602:80d:1005::/48 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 2602:80d:1006::/48 >> /root/data/log/m320.log 2>&1
sudo ufw deny from 2620:96:e000::/48 >> /root/data/log/m320.log 2>&1
echo "y" | sudo ufw enable >> /root/data/log/m320.log 2>&1
echo -e "[${green}OK${white}] $mikublue 9/11 UFW配置完成" $white

apt install fail2ban -y >> /root/data/log/m320.log 2>&1
systemctl enable fail2ban >> /root/data/log/m320.log 2>&1
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local >> /root/data/log/m320.log 2>&1
rm -rf /etc/fail2ban/jail.d/* >> /root/data/log/m320.log 2>&1
wget -O /etc/fail2ban/jail.d/sshd.local https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/systools/firewall/fail2ban/sshd.local >> /root/data/log/m320.log 2>&1
systemctl restart fail2ban >> /root/data/log/m320.log 2>&1
echo -e "[${green}OK${white}] $mikublue 10/11 fail2ban部署完成" $white

echo "**************************************************************************"

sudo echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf >> /root/data/log/m320.log 2>&1
sudo echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf >> /root/data/log/m320.log 2>&1
sudo sysctl -p >> /root/data/log/m320.log 2>&1
echo -e "[${green}OK${white}] $mikublue 11/11. BBR_FQ已开启" $white

#写入水印

cat > /etc/motd <<EOF

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.

**************************************************************************
 _       __      __  ____
| |     / /     / / / __ \   _____  ___    _____ _   __  ___    _____
| | /| / / __  / / / / / /  / ___/ / _ \  / ___/| | / / / _ \  / ___/
| |/ |/ / / /_/ / / /_/ /  (__  ) /  __/ / /    | |/ / /  __/ / /
|__/|__/  \____/  \___\_\ /____/  \___/ /_/     |___/  \___/ /_/

               _____   __                __    _
              / ___/  / /_  __  __  ____/ /   (_)  ____
              \__ \  / __/ / / / / / __  /   / /  / __ \ 
             ___/ / / /_  / /_/ / / /_/ /   / /  / /_/ /
            /____/  \__/  \__,_/  \__,_/   /_/   \____/

**************************************************************************

EOF

echo "环境部署完成"