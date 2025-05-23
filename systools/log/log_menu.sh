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

# 日志存至硬盘
function disk(){
    wget -O log_disk.sh ${repo_url}systools/log/log_disk.sh && chmod +x log_disk.sh && ./log_disk.sh
}

# 日志快速刷写
function flush(){
    wget -O log_flush.sh ${repo_url}systools/log/log_flush.sh && chmod +x log_flush.sh && ./log_flush.sh
}

# 不存储日志
function none(){
    wget -O log_none.sh ${repo_url}systools/log/log_none.sh && chmod +x log_none.sh && ./log_none.sh
}

# 限制日志大小
function limit(){
    wget -O log_limit.sh ${repo_url}systools/log/log_limit.sh && chmod +x log_limit.sh && ./log_limit.sh
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
    option 1 "日志存至硬盘" 
    option 2 "日志快速刷写"
    option 3 "不存储日志"
    option 4 "限制日志大小"
    green " =================================================="
    option 0 "返回主脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           disk
        ;;
        2 )
           flush
        ;;
        3 )
           none
        ;;
        4 )
           limit
        ;;
        0 )
           back
        ;;

        * )
            clear
            red "请输入正确数字 !"
            sleep 1
            start_menu
        ;;
    esac
}
start_menu "first"
