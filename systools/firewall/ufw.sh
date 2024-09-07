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

# 添加警告提示
read -p "警告：执行此脚本将配置 UFW 并启用防火墙。确保您具有必要的权限并理解脚本的功能。继续吗？(Y/N): " confirm
if [[ $confirm != "Y" && $confirm != "y" ]]; then
  echo "脚本已取消。"
  exit 0
fi

read -p "请输入SSH端口(请确保输入正确以开启UFW防火墙端口): " PORT

#使用通用脚本安装依赖
wget -O install.sh ${repo_url}/install.sh && chmod +x install.sh && ./install.sh ufw

#UFW配置
sudo ufw default deny incoming 
sudo ufw default allow outgoing 
sudo ufw allow $PORT 
sudo ufw allow 80 
sudo ufw allow 443  
sudo ufw deny from 162.142.125.0/24 
sudo ufw deny from 167.94.138.0/24 
sudo ufw deny from 167.94.145.0/24 
sudo ufw deny from 167.94.146.0/24 
sudo ufw deny from 167.248.133.0/24 
sudo ufw deny from 199.45.154.0/24 
sudo ufw deny from 199.45.155.0/24 
sudo ufw deny from 206.168.35.0/24 
sudo ufw deny from 206.168.34.0/24 
sudo ufw deny from 206.168.33.0/24 
sudo ufw deny from 206.168.32.0/24 
sudo ufw deny from 2602:80d:1000::/48 
sudo ufw deny from 2602:80d:1001::/48 
sudo ufw deny from 2602:80d:1002::/48 
sudo ufw deny from 2602:80d:1003::/48 
sudo ufw deny from 2602:80d:1004::/48 
sudo ufw deny from 2602:80d:1005::/48 
sudo ufw deny from 2602:80d:1006::/48 
sudo ufw deny from 2620:96:e000::/48 
echo "y" | sudo ufw enable 
echo -e "[${green}OK${white}] $mikublue UFW配置完成" $white

apt install fail2ban -y 
systemctl enable fail2ban 
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local 
rm -rf /etc/fail2ban/jail.d/* 
wget -O /etc/fail2ban/jail.d/sshd.local https://raw.githubusercontent.com/WJQSERVER-STUDIO/tools-stable/main/systools/firewall/fail2ban/sshd.local 
systemctl restart fail2ban 
echo -e "[${green}OK${white}] $mikublue fail2ban部署完成" $white

echo "UFW 已成功部署！"
echo "防火墙已启用，并且只允许指定的端口通过。"

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
