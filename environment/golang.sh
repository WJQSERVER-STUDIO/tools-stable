#! /bin/bash
#https://github.com/WJQSERVER/tools-stable
# deploy golang environment

mikublue="\033[38;2;57;197;187m"
yellow='\033[33m'
white='\033[0m'
green='\033[0;32m'
blue='\033[0;34m'
red='\033[31m'
gray='\e[37m'

version="1.23.2"

echo -e "[${green}RUN${white}] $mikublue 開始安裝GO環境" $white
echo -e "${green}>${white} $mikublue     拉取安裝包" $white
wget -q https://go.dev/dl/go$version.linux-amd64.tar.gz
echo -e "${green}>${white} $mikublue     清理目錄" $white
echo -e "${green}>${white} $mikublue     解壓安裝包" $white
rm -rf /usr/local/go && tar -C /usr/local -xzf go$version.linux-amd64.tar.gz
echo -e "${green}>${white} $mikublue     添加環境變量" $white
echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile
echo -e "${green}>${white} $mikublue     導入變量" $white
source /etc/profile
echo -e "${green}>${white} $mikublue     測試安裝狀態" $white
go version

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O environment-menu.sh ${repo_url}environment/environment-menu.sh && chmod +x environment-menu.sh && ./environment-menu.sh
else
    echo "脚本结束"
fi
