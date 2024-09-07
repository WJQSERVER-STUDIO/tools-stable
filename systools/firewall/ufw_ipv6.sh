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

# 提示用户输入端口号
read -p "请输入要开启的 IPv6 端口号（1-65535）： " port

# 检查端口范围
if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
    echo "[${red}ERROR${white}]错误：端口号必须在 1 到 65535 之间。"
    exit 1
fi

# 开启指定端口
ufw allow from ::/0 to any port "$port"

# 输出结果
echo -e "[${green}OK${white}] $mikublue 已成功开启 IPv6 端口 $port。$white "

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O firewall_menu.sh ${repo_url}systools/firewall/firewall_menu.sh && chmod +x firewall_menu.sh && ./firewall_menu.sh
else
    echo "脚本结束"
fi