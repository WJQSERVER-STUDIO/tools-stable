#! /bin/bash
# By WJQSERVER-STUDIO_WJQSERVER
#https://github.com/WJQSERVER/tools-dev

clear

# 显示免责声明
echo "免责声明：请阅读并同意以下条款才能继续使用本脚本。"
echo "本脚本仅供学习和参考使用，作者不对其完整性、准确性或实用性做出任何保证。"
echo "使用本脚本所造成的任何损失或损害，作者不承担任何责任。"

# 导入配置文件
source "repo_url.conf"
sleep 1

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

function create_user(){
    wget -O create_user.sh ${repo_url}systools/user/create_user.sh && chmod +x create_user.sh && ./create_user.sh
}

function user_management(){
    wget -O user_management.sh ${repo_url}systools/user/user_management.sh && chmod +x user_management.sh && ./user_management.sh
}

#返回主脚本
function back(){
    wget -O systools-menu.sh ${repo_url}systools/systools-menu.sh && chmod +x systools-menu.sh && ./systools-menu.sh
}

#主菜单
function start_menu(){
    clear
    yellow " WJQserver Studio 工具箱 Stable"
    green " WJQserver Studio tools-stable" 
    yellow " FROM: https://github.com/WJQSERVER/tools-stable "
    green " USE:  wget -O tools.sh ${repo_url}tools.sh && chmod +x tools.sh && clear && ./tools.sh "
    yellow " =================================================="
    green " 1. 新建用户" 
    green " 2. 管理已有用户"
    yellow " =================================================="
    green " 0. 返回主脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           create_user
	    ;;
        2 )
	       user_management
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
