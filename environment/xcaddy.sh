#! /bin/bash
#https://github.com/WJQSERVER/tools-stable
# deploy XCaddy environment

mikublue="\033[38;2;57;197;187m"
yellow='\033[33m'
white='\033[0m'
green='\033[0;32m'
blue='\033[0;34m'
red='\033[31m'
gray='\e[37m'

go_version="1.24.0"

echo -e "[${green}RUN${white}] $mikublue 開始安裝XCaddy環境" $white
echo -e "${green}>${white} $mikublue 更新軟件包" $white
apt update
apt upgrade -y
echo -e "${green}>${white} $mikublue 拉取必要依賴" $white
apt install curl vim wget gnupg dpkg apt-transport-https lsb-release ca-certificates

echo -e "${green}>${white} $mikublue 拉取GO安裝包" $white
wget https://go.dev/dl/go${go_version}.linux-amd64.tar.gz
echo -e "${green}>${white} $mikublue 清理GO相關目錄" $white
echo -e "${green}>${white} $mikublue 解壓GO安裝包" $white
rm -rf /usr/local/go && tar -C /usr/local -xzf go${go_version}.linux-amd64.tar.gz
echo -e "${green}>${white} $mikublue 添加GO環境變量" $white
echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile
echo -e "${green}>${white} $mikublue 導入GO變量" $white
source /etc/profile
echo -e "${green}>${white} $mikublue 測試GO安裝狀態" $white
go version

echo -e "${green}>${white} $mikublue 添加XCaddy源" $white
curl -sSL https://dl.cloudsmith.io/public/caddy/xcaddy/gpg.key | gpg --dearmor > /usr/share/keyrings/xcaddy.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/xcaddy.gpg] https://dl.cloudsmith.io/public/caddy/xcaddy/deb/debian any-version main" > /etc/apt/sources.list.d/xcaddy.list

echo -e "${green}>${white} $mikublue 安裝XCaddy" $white
apt update
apt install xcaddy

cd /root
source "repo_url.conf"
sleep 1
read -p "是否返回菜单?: [Y/n]" choice
if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O environment-menu.sh ${repo_url}environment/environment-menu.sh && chmod +x environment-menu.sh && ./environment-menu.sh
else
    echo "脚本结束"
fi
