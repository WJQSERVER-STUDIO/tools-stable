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

#青龙tools
function qltools(){
    wget -O qinglong-panel-tools.sh ${repo_url}program/qinglong-panel/qinglong-panel-tools.sh && chmod +x qinglong-panel-tools.sh && ./qinglong-panel-tools.sh
}

#京东Pro
function jdpro(){
    wget -O qinglong-panel-jdpro.sh ${repo_url}program/qinglong-panel/qinglong-panel-jdpro.sh && chmod +x qinglong-panel-jdpro.sh && ./qinglong-panel-jdpro.sh
}

#京东rabbit
function jdrabbit(){
    wget -O qinglong-panel-jdrabbit.sh ${repo_url}program/qinglong-panel/qinglong-panel-jdrabbit.sh && chmod +x qinglong-panel-jdrabbit.sh && ./qinglong-panel-jdrabbit.sh
}

#饿了么面板
function elmmb(){
    wget -O qinglong-panel-elmmb.sh ${repo_url}program/qinglong-panel/qinglong-panel-elmmb.sh && chmod +x qinglong-panel-elmmb.sh && ./qinglong-panel-elmmb.sh
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
    green " 1. 青龙tools" 
    green " 2. 京东Pro"
    green " 3. 京东rabbit"
    green " 4. 饿了么面板" 
    yellow " =================================================="
    green " 0. 返回主脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           qltools
	    ;;
        2 )
	       jdpro
        ;;
	    3 )
           jdrabbit
	    ;;
        4 )
	       elmmb
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
