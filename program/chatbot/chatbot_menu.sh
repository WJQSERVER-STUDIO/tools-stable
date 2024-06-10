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

#
function koishi(){
    wget -O koishi.sh ${repo_url}program/chatbot/koishi.sh && chmod +x koishi.sh && ./koishi.sh
}

#
function ntqq(){
    wget -O ntqq.sh ${repo_url}program/chatbot/ntqq.sh && chmod +x ntqq.sh && ./ntqq.sh
}

#返回主脚本
function back(){
    wget -O program-menu.sh ${repo_url}program/program-menu.sh && chmod +x program-menu.sh && ./program-menu.sh
}

#主菜单
function start_menu(){
    clear
    yellow " WJQserver Studio 工具箱 BETA版 "
    green " WJQserver Studio tools BETA" 
    yellow " FROM: https://github.com/WJQSERVER/tools-dev "
    green " USE:  wget -O tools.sh ${repo_url}tools.sh && chmod +x tools.sh && clear && ./tools.sh "
    yellow " =================================================="
    green " 1. Koishi" 
    green " 2. NTQQ"
    yellow " =================================================="
    green " 0. 返回主脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           koishi
	    ;;
        2 )
	       ntqq
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
