#! /bin/bash
# By WJQSERVER-STUDIO_WJQSERVER
#https://github.com/WJQSERVER/tools-stable

# 导入配置文件
source "repo_url.conf"
sleep 1

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

#修改主机名
function change_hostname(){
    wget -O change_hostname.sh ${repo_url}systools/change_hostname.sh && chmod +x change_hostname.sh && ./change_hostname.sh
}

#修改时区
function timezone(){
    wget -O timezone.sh ${repo_url}systools/timezone.sh && chmod +x timezone.sh && ./timezone.sh
}

#修改密码
function password(){
    wget -O password_menu.sh ${repo_url}systools/password/password_menu.sh && chmod +x password_menu.sh && ./password_menu.sh
}

#修改SSH配置
function ssh(){
    wget -O ssh_menu.sh ${repo_url}systools/ssh/ssh_menu.sh && chmod +x ssh_menu.sh && ./ssh_menu.sh
}

#用户管理
function user(){
    wget -O user_menu.sh ${repo_url}systools/user/user_menu.sh && chmod +x user_menu.sh && ./user_menu.sh
}

#网络配置
function network(){
    wget -O network_menu.sh ${repo_url}systools/network/network_menu.sh && chmod +x network_menu.sh && ./network_menu.sh
}

#日志配置
function log(){
    wget -O log_menu.sh ${repo_url}systools/log/log_menu.sh && chmod +x log_menu.sh && ./log_menu.sh
}

#防火墙
function firewall(){
    wget -O firewall_menu.sh ${repo_url}systools/firewall/firewall_menu.sh && chmod +x firewall_menu.sh && ./firewall_menu.sh
}

#SWAP
function swap(){
    wget -O swap.sh ${repo_url}systools/swap.sh && chmod +x swap.sh && ./swap.sh
}

#反腾讯云控
function antitencent(){
    wget -O anti_tencent_ctrl.sh ${repo_url}systools/anti_tencent_ctrl.sh && chmod +x anti_tencent_ctrl.sh && ./anti_tencent_ctrl.sh
}

#一键DD
function dd(){
    wget -O dd_menu.sh ${repo_url}systools/dd/dd_menu.sh && chmod +x dd_menu.sh && ./dd_menu.sh
}

#重启
function reboot(){
echo "即将重启"
sleep 3    
reboot    
}

#返回主脚本
function back(){
    wget -O main.sh ${repo_url}main.sh && chmod +x main.sh && ./main.sh
}

#主菜单
function start_menu(){
    clear
    red " WJQserver Studio Linux工具箱"
    yellow " FROM: https://github.com/WJQSERVER-STUDIO/tools-stable "
    green " =================================================="
    option 1 "修改主机名"
    option 2 "修改时区"
    option 3 "修改密码"
    option 4 "修改SSH配置"
    option 5 "用户管理"
    green " =================================================="
    option 6 "修改网络配置&BBR"
    option 7 "修改日志配置"
    option 8 "防火墙配置"
    green " =================================================="
    option 9 "SWAP配置"
    green " =================================================="
    option 10 "解除腾讯云控"
    green " =================================================="
    option 90 "一键DD系统"
    option 99 "重启"
    green " =================================================="
    option 0 "返回主脚本"

    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           change_hostname
	    ;;
        2 )
	       timezone
        ;;
	    3 )
           password
	    ;;
        4 )
	       ssh
        ;;
	     5 )
           user
	    ;;
        6 )
	       network
        ;;
	    7 )
           log
	    ;;
        8 )
           firewall
        ;;
        9 )
           swap
        ;;
        10)
           antitencent
        ;;
        90)
           dd
        ;;
        99)
           reboot
        ;;         

        0)
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
