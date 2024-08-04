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

#
function networkinfo(){
    wget -O networkinfo.sh ${repo_url}systools/network/networkinfo.sh && chmod +x networkinfo.sh && ./networkinfo.sh
}

#
function ipv_switch(){
    wget -O ipv-switch.sh ${repo_url}systools/network/ipv-switch.sh && chmod +x ipv-switch.sh && ./ipv-switch.sh
}

#
function bbr(){
    wget -O bbr-manager.sh ${repo_url}systools/network/bbr-manager.sh && chmod +x bbr-manager.sh && ./bbr-manager.sh
}

#
function change_dns(){
    wget -O change_dns.sh ${repo_url}systools/network/change_dns.sh && chmod +x change_dns.sh && ./change_dns.sh
}

#
function check_port_usage(){
    wget -O check_port_usage.sh ${repo_url}systools/network/check_port_usage.sh && chmod +x check_port_usage.sh && ./check_port_usage.sh
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
    option 1 "網路側信息查看" 
    option 2 "IPv4/IPv6優先級切換"
    option 3 "BBR管理面板"
    option 4 "更換DNS"
    option 5 "檢測端口占用"
    green " =================================================="
    option 0 "返回主脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           networkinfo
	    ;;
        2 )
	       ipv_switch
        ;;
	    3 )
           bbr
	    ;;
        4 )
	       change_dns
        ;;
	    5 )
           check_port_usage
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
