#! /bin/bash
# By WJQSERVER-STUDIO_WJQSERVER
#https://github.com/WJQSERVER/tools-stable

# 导入配置文件
source "repo_url.conf"

# 获取当前版本并设置5秒超时
version=$(curl -s --max-time 5 ${repo_url}Version)
if [ $? -ne 0 ]; then
    version="unknown"  # 设置默认值或进行其他错误处理
fi

# 获取统计信息并设置5秒超时
total=$(curl -s --max-time 5 https://count.1888866.xyz/api/counter/total)
if [ $? -ne 0 ]; then
    total="unknown"  # 设置默认值或进行其他错误处理
fi

today=$(curl -s --max-time 5 https://count.1888866.xyz/api/counter/daily)
if [ $? -ne 0 ]; then
    today="unknown"  
fi

# 统计次数
response=$(curl -s --max-time 5 https://count.1888866.xyz/add)
if [ $? -ne 0 ]; then
    echo 
else
    echo 
fi

mikublue="\033[38;2;57;197;187m\033[01m"
yellow='\033[33m\033[01m'
white='\033[0m\033[01m'
green='\033[0;32m\033[01m'
blue='\033[0;34m\033[01m'
red='\033[31m\033[01m'
gray='\e[37m\033[01m'

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
menu-option(){
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

#webserver
function webserver(){
    wget -O webserver_menu.sh ${repo_url}program/webserver/webserver_menu.sh && chmod +x webserver_menu.sh && ./webserver_menu.sh
}

#Docker管理WEBUI
function docker_manager_webui(){
    wget -O docker_manager_webui_menu.sh ${repo_url}program/docker_manager_webui/docker_manager_webui_menu.sh && chmod +x docker_manager_webui_menu.sh && ./docker_manager_webui_menu.sh
}

#Speedtest测速
function speedtest(){
    wget -O speedtest_menu.sh ${repo_url}program/speedtest/speedtest_menu.sh && chmod +x speedtest_menu.sh && ./speedtest_menu.sh
}

#SyncThing同步工具
function syncthing(){
    wget -O syncthing.sh ${repo_url}program/syncthing/syncthing.sh && chmod +x syncthing.sh && ./syncthing.sh
}

#探针
function monitor(){
    wget -O monitor_menu.sh ${repo_url}program/monitor/monitor_menu.sh && chmod +x monitor_menu.sh && ./monitor_menu.sh
}

#uptime-kuma
function uptime-kuma(){
    wget -O uptime-kuma.sh ${repo_url}program/uptime/uptime-kuma.sh && chmod +x uptime-kuma.sh && ./uptime-kuma.sh
}

#WebSSH
function webssh(){
    wget -O webssh.sh ${repo_url}program/webssh/webssh.sh && chmod +x webssh.sh && ./webssh.sh
}

#IP信息查询
function ip(){
    wget -O ip_menu.sh ${repo_url}program/ip/ip_menu.sh && chmod +x ip_menu.sh && ./ip_menu.sh
}

#Git服务器
function gits(){
    wget -O gits_menu.sh ${repo_url}program/gits/gits_menu.sh && chmod +x gits_menu.sh && ./gits_menu.sh
}

#Github代理
function ghproxy(){
    wget -O ghproxy.sh ${repo_url}program/ghproxy/ghproxy.sh && chmod +x ghproxy.sh && ./ghproxy.sh
}

#青龙面板
function qinglong(){
    wget -O qinglong.sh ${repo_url}program/qinglong/qinglong.sh && chmod +x qinglong.sh && ./qinglong.sh
}

#One-Api(AI API聚合)
function one-api(){
    wget -O one-api.sh ${repo_url}program/ai/one-api.sh && chmod +x one-api.sh && ./one-api.sh
}

# SyncThing同步工具
function syncthing(){
    wget -O syncthing.sh ${repo_url}program/syncthing/syncthing.sh && chmod +x syncthing.sh && ./syncthing.sh
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
    menu-option 1 "网站服务器                          ${green}2. ${mikublue}Docker管理WEBUI${white}"
    menu-option 3 "Speedtest测速                       ${green}4. ${mikublue}SyncThing同步工具${white}"
    menu-option 5 "服务器探针                          ${green}6. ${mikublue}Uptime-Kuma${white}"
    menu-option 7 "WebSSH                             ${green}8. ${mikublue}IP信息查询${white}"
    menu-option 9 "Git服务器                           ${green}10. ${mikublue}Github代理${white}"
    menu-option 11 "青龙面板                           ${green}12. ${mikublue}One-Api(AI API聚合)${white}"
    menu-option 13 "SyncThing同步工具                   "
    green " =================================================="
    option 0 "退出脚本"
    echo
    read -p " 请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           webserver
        ;;
        2 )
           docker_manager_webui
        ;;
        3 )
           speedtest
        ;;
        4 )
           syncthing
        ;;
        5 )
           monitor
        ;;
        6 )
           uptime-kuma
        ;;
        7 )
           webssh
        ;;
        8 )
           ip
        ;;
        9 )
           gits
        ;;
        10 )
           ghproxy
        ;;
        11 )
           qinglong
        ;;
        12 )
           one-api
        ;;
        0 )
           back
        ;;
	
        * )
            clear
            red "请输入正确数字!"
            start_menu
        ;;
    esac
}
start_menu "first"
