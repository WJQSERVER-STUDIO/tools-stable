#! /bin/bash
# By WJQSERVER-STUDIO_WJQSERVER
#https://github.com/WJQSERVER/tools

mikublue="\033[38;2;57;197;187m"
yellow='\033[33m'
white='\033[0m'
green='\033[0;32m'
blue='\033[0;34m'
red='\033[31m'
gray='\e[37m'

clear

# 显示免责声明
echo -e "${yellow}免责声明：请阅读并同意以下条款才能继续使用本脚本。"
echo -e "${mikublue}本脚本仅供学习和参考使用，作者不对其完整性、准确性或实用性做出任何保证。"
echo -e "${mikublue}使用本脚本所造成的任何损失或损害，作者不承担任何责任。"
echo -e "${mikublue}不提供/保证任何功能的可用性，安全性，有效性，合法性"
echo -e "${mikublue}当前版本为${red}V.1.0${white}"

sleep 1

conf_file="repo_url.conf"

#Stable版
repo_url="https://raw.githubusercontent.com/WJQSERVER/tools/main/"

echo "repo_url=$repo_url" > "$conf_file"

# 导入配置文件
source "repo_url.conf"

# 显示确认提示
read -p "您是否同意上述免责声明？(y/n): " confirm

# 处理确认输入
if [[ $confirm != [Yy] ]]; then
    echo "您必须同意免责声明才能继续使用本脚本。"
    exit 1
fi

# 确认执行操作
read -p "此操作将安装 wget, curl, vim 等常用软件包并进行更新。是否继续？(不进行此操作可能造成脚本异常)(y/n) " choice

if [[ $choice == "y" ]]; then
  # 安装软件包
  apt update
  apt install wget curl vim git sudo -y
  apt upgrade -y
fi

#彩色
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

#主脚本
wget -O main.sh ${repo_url}main.sh && chmod +x main.sh && clear && ./main.sh
