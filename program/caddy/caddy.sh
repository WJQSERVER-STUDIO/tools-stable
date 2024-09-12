#! /bin/bash
# By WJQSERVER-STUDIO_WJQSERVER
#https://github.com/WJQSERVER/tools-stable

# 导入配置文件
source "repo_url.conf"

mikublue="\033[38;2;57;197;187m"
yellow='\033[33m'
white='\033[0m'
green='\033[0;32m'
blue='\033[0;34m'
red='\033[31m'
gray='\e[37m'

#彩色
mikublue(){
    echo -e "\033[38;2;57;197;187m\033[01m$1\033[0m"
}
white(){
    echo -e "\033[0m\033[01m$1\033[0m"
}
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
gray(){
    echo -e "\e[37m\033[01m$1\033[0m"
}
option(){
    echo -e "\033[32m\033[01m ${1}. \033[38;2;57;197;187m${2}\033[0m"
}

clear

# 显示免责声明
echo -e "${red}免责声明：${mikublue}请阅读并同意以下条款才能继续使用本脚本。"
echo -e "${yellow}===================================================================="
echo -e "${mikublue}本脚本仅供学习和参考使用，作者不对其完整性、准确性或实用性做出任何保证。"
echo -e "${mikublue}使用本脚本所造成的任何损失或损害，作者不承担任何责任。"
echo -e "${mikublue}不提供/保证任何功能的可用性，安全性，有效性，合法性"
echo -e "${mikublue}当前版本为${white}  [${yellow} V.0.9 ${white}]  ${white}"
echo -e "${yellow}===================================================================="
sleep 1

echo -e "[${yellow}RUN${white}] $mikublue 開始安裝Caddy" $white

echo -e "${green}>${white} $mikublue 創建安裝目錄" $white
mkdir -p /root/data/caddy
mkdir -p /root/data/caddy/config
echo -e "${green}>${white} $mikublue 下載主程序" $white
VERSION=$(curl -s https://raw.githubusercontent.com/WJQSERVER-STUDIO/caddy/main/VERSION)
wget -q -O /root/data/caddy/caddy.tar.gz https://github.com/WJQSERVER-STUDIO/caddy/releases/download/$VERSION/caddy-linux-amd64-pages.tar.gz
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
if [ ! -f /root/data/caddy/Caddyfile ]; then
    wget -q -O /root/data/caddy/Caddyfile https://raw.githubusercontent.com/WJQSERVER-STUDIO/tools-stable/main/program/caddy/caddyfile
fi
if [ ! -f /root/data/caddy/config/80 ]; then
    wget -q -O /root/data/caddy/config/80 https://raw.githubusercontent.com/WJQSERVER-STUDIO/tools-stable/main/program/caddy/80
fi

＃wget -q -O /root/data/caddy/Caddyfile https://raw.githubusercontent.com/WJQSERVER-STUDIO/tools-stable/main/program/caddy/caddyfile
＃wget -q -O /root/data/caddy/config/80 https://raw.githubusercontent.com/WJQSERVER-STUDIO/tools-stable/main/program/caddy/80

echo -e "${green}>${white} $mikublue 啟動程序" $white
systemctl daemon-reload
systemctl enable caddy.service
systemctl start caddy.service
echo -e "[${green}OK${white}] $mikublue caddy安装完成" $white
