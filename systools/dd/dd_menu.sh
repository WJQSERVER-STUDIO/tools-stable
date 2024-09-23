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

# 判断用户是否为root用户
if [ $(id -u)!= "0" ]; then
    echo -e "${red}请以root用户身份运行脚本！"
    exit 1
fi

function debain-12(){
    echo "即将安装Debian-12系统,原系统数据将被清空"
    sleep 1
    read -p "输入新系统密码:" PASSWORD
    wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh && bash InstallNET.sh -debian 12 -pwd $PASSWORD --bbr
}

function debian-11(){
    echo "即将安装Debian-11系统,原系统数据将被清空"
    sleep 1
    read -p "输入新系统密码:" PASSWORD
    wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh && bash InstallNET.sh -debian 11 -pwd $PASSWORD    
}

function debian-10(){
    echo "即将安装Debian-10系统,原系统数据将被清空"
    sleep 1
    read -p "输入新系统密码:" PASSWORD
    wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh && bash InstallNET.sh -debian 10 -pwd $PASSWORD   
}

function alpine-edge(){
    echo "即将安装Alpine-Edge系统,原系统数据将被清空"
    sleep 1
    read -p "输入新系统密码:" PASSWORD
    wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh && bash InstallNET.sh -alpine -pwd $PASSWORD      
}

function ubuntu-22(){
    echo "即将安装Ubuntu-22.04系统,原系统数据将被清空"
    sleep 1
    read -p "输入新系统密码:" PASSWORD
    wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh && bash InstallNET.sh -ubuntu 22.04 -pwd $PASSWORD 
}

function ubuntu-20(){
    echo "即将安装Ubuntu-20.04系统,原系统数据将被清空"
    sleep 1
    read -p "输入新系统密码:" PASSWORD
    wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh && bash InstallNET.sh -ubuntu 20.04 -pwd $PASSWORD 
}

function almalinux-9(){
    echo "即将安装Almalinux-9系统,原系统数据将被清空"
    sleep 1
    read -p "输入新系统密码:" PASSWORD
    wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh && bash InstallNET.sh -almalinux 9 -pwd $PASSWORD
}

function centos-stream(){
    echo "即将安装CentOS-9 Stream系统,原系统数据将被清空"
    sleep 1
    read -p "输入新系统密码:" PASSWORD
    wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh && bash InstallNET.sh -centos -pwd $PASSWORD
}

#返回主脚本
function back(){
    wget -O systools-menu.sh ${repo_url}systools/systools-menu.sh && chmod +x systools-menu.sh && ./systools-menu.sh
}

clear
#主菜单
function start_menu(){
    clear
    red " WJQserver Studio Linux工具箱"
    yellow " 工具箱 FROM: https://github.com/WJQSERVER-STUDIO/tools-stable "
    yellow " DD脚本 FROM: https://github.com/leitbogioro/Tools"
    green " =================================================="
    option 1 "Debian-12"
    option 2 "Debian-11"
    option 3 "Debian-10"
    option 4 "Ubuntu-22.04"
    option 5 "Ubuntu-20.04"
    option 6 "Alpine-Edge"
    option 7 "CentOS-9 Stream"
    option 8 "Almalinux-9"
    green " =================================================="
    option 0 "返回主脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
            debain-12
        ;;
        2 )
            debian-11
        ;;
        3 )
            debian-10
        ;;
        4 )
            ubuntu-22
        ;;
        5 )
            ubuntu-20
        ;;
        6 )
            alpine-edge
        ;;
        7 )
            centos-stream
        ;;
        8 )
            almalinux-9
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
