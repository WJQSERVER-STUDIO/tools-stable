#! /bin/bash
# By WJQSERVER-STUDIO_WJQSERVER
#https://github.com/WJQSERVER/tools-stable

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

function debain12(){
    echo "即将安装Debian-12系统,原系统数据将被清空"
    sleep 1
    read -p "输入新系统密码:" PASSWORD
    wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh && bash InstallNET.sh -debian 12 -pwd $PASSWORD
}

function debian11(){
    echo "即将安装Debian-11系统,原系统数据将被清空"
    sleep 1
    read -p "输入新系统密码:" PASSWORD
    wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh && bash InstallNET.sh -debian 11 -pwd $PASSWORD    
}

function debian10(){
    echo "即将安装Debian-10系统,原系统数据将被清空"
    sleep 1
    read -p "输入新系统密码:" PASSWORD
    wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh && bash InstallNET.sh -debian 10 -pwd $PASSWORD   
}

function alpine(){
    echo "即将安装Alpine-Edge系统,原系统数据将被清空"
    sleep 1
    read -p "输入新系统密码:" PASSWORD
    wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh && bash InstallNET.sh -alpine -pwd $PASSWORD      
}

function ubuntu(){
    echo "即将安装Ubuntu-22.04系统,原系统数据将被清空"
    sleep 1
    read -p "输入新系统密码:" PASSWORD
    wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh && bash InstallNET.sh -ubuntu 22.04 -pwd $PASSWORD 
}

function almalinux(){
    echo "即将安装Almalinux-9系统,原系统数据将被清空"
    sleep 1
    read -p "输入新系统密码:" PASSWORD
    wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh && bash InstallNET.sh -almalinux 9 -pwd $PASSWORD
}

function centos(){
    echo "即将安装CentOS-8系统,原系统数据将被清空"
    sleep 1
    read -p "输入新系统密码:" PASSWORD
    wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh && bash InstallNET.sh -centos 8 -pwd $PASSWORD
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
    yellow " DD Script FROM: https://github.com/leitbogioro/Tools"
    yellow " =================================================="
    green " 1. Debian-12" 
    green " 2. Debian-11"
    green " 3. Debian-10"
    green " 4. Alpine-Edge" 
    green " 5. Ubuntu-22.04"
    green " 6. AlmaLinux-9"
    green " 7. CentOS-8"
    yellow " =================================================="
    green " 0. 返回主脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           debain12
	    ;;
        2 )
	       debian11
        ;;
	    3 )
           debian10
	    ;;
        4 )
	       alpine
        ;;
	    5 )
           ubuntu
	    ;;
        6 )
	       almalinux
        ;;
	    7 )
           centos
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
