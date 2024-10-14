#! /bin/bash
# By WJQSERVER-STUDIO_WJQSERVER
#https://github.com/WJQSERVER-STUDIO/tools-stable

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

version=$(curl -s --max-time 3 ${repo_url}Version)
if [ $? -ne 0 ]; then
    version="unknown"  
fi

clear

# 显示免责声明
echo -e "${red}免责声明：${mikublue}请阅读并同意以下条款才能继续使用本脚本。"
echo -e "${yellow}===================================================================="
echo -e "${mikublue}本脚本仅供学习和参考使用，作者不对其完整性、准确性或实用性做出任何保证。"
echo -e "${mikublue}使用本脚本所造成的任何损失或损害，作者不承担任何责任。"
echo -e "${mikublue}不提供/保证任何功能的可用性，安全性，有效性，合法性"
echo -e "${mikublue}当前版本为${white}  [${yellow} V${version} ${white}]  ${white}"
echo -e "${yellow}===================================================================="
sleep 1

# 检测UFW是否安装
if ! command -v ufw &> /dev/null; then
    echo -e "${red}UFW未安装，请先安装UFW。"
    exit 1
fi

echo -e "[${red}WARNING${white}] 即将禁止ICMP流量，是否继续？"
read -p "输入[Y/n]:" answer
if [ "$answer" == "n" ]; then
    echo -e "${red}已取消操作。"
    exit 1
fi

# 备份UFW配置
echo -e "${green}正在备份UFW配置..."
sudo cp /etc/ufw/before.rules /etc/ufw/before.rules.bak
echo -e "${green}备份成功！"

# 禁止ICMP流量
echo -e "${green}正在禁止ICMP流量..."
sed -i.bak '/-A ufw-before-input -p icmp/ s/-j ACCEPT/-j DROP/' /etc/ufw/before.rules

# 重载UFW配置
echo -e "${green}正在重载UFW配置..."
sudo ufw reload
echo -e "${green}重载成功！"

echo -e "${green}IPV4 ICMP流量已禁止。"