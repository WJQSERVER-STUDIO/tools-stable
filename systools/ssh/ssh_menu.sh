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

function change_ssh_port(){
    wget -O change_ssh_port.sh ${repo_url}systools/ssh/change_ssh_port.sh && chmod +x change_ssh_port.sh && ./change_ssh_port.sh
}

function ssh_connect(){
    wget -O ssh_connect.sh ${repo_url}systools/ssh/ssh_connect.sh && chmod +x ssh_connect.sh && ./ssh_connect.sh
}

#返回主脚本
function back(){
    wget -O systools-menu.sh ${repo_url}systools/systools-menu.sh && chmod +x systools-menu.sh && ./systools-menu.sh
}

#主菜单
function start_menu(){
    clear
    red " WJQserver Studio Linux工具箱"
    yellow " FROM: https://github.com/WJQSERVER-STUDIO/tools-stable "
    green " =================================================="
    option 1 "修改SSH端口" 
    option 2 "新建对外SSH链接"
    green " =================================================="
    option 0 "返回主脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           change_ssh_port
        ;;
        2 )
           ssh_connect
        ;;
        0 )
           back
        ;;
        
        * )
            clear
            red "请输入正确数字 !"
            start_menu
        ;;
    esac
}
start_menu "first"
