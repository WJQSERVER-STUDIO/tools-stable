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
    yellow " WJQserver Studio 工具箱 Stable"
    green " WJQserver Studio tools-stable" 
    yellow " FROM: https://github.com/WJQSERVER/tools-stable "
    green " USE:  wget -O tools.sh ${repo_url}tools.sh && chmod +x tools.sh && clear && ./tools.sh "
    yellow " =================================================="
    green " 1. 網路側信息查看" 
    green " 2. IPv4/IPv6優先級切換"
    green " 3. BBR管理面板"
    green " 4. 更換DNS" 
    green " 5. 檢測端口占用"
    yellow " =================================================="
    green " 0. 返回主脚本"
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
