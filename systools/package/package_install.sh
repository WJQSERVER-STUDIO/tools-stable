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

#sudo
function sudo(){
    wget -O install.sh ${repo_url}systools/install.sh && chmod +x install.sh && ./install.sh sudo
}

#vim
function vim(){
    wget -O install.sh ${repo_url}systools/install.sh && chmod +x install.sh && ./install.sh vim
}

#tar
function tar(){
    wget -O install.sh ${repo_url}systools/install.sh && chmod +x install.sh && ./install.sh tar
}

#zstd
function zstd(){
    wget -O install.sh ${repo_url}systools/install.sh && chmod +x install.sh && ./install.sh zstd
}

#git
function git(){
    wget -O install.sh ${repo_url}systools/install.sh && chmod +x install.sh && ./install.sh git
}

#lsof
function lsof(){
    wget -O install.sh ${repo_url}systools/install.sh && chmod +x install.sh && ./install.sh lsof
}

# diy
function diy(){
    echo -e "${green}> ${mikublue}请在下方输入你要安装的软件名称，例如：zstd、git、lsof等。"
    read -p "> 请输入软件名称:" softwareName
    if [ -z "$softwareName" ]; then
        echo -e "${red}请输入正确的软件名称！"
        diy
    else
        wget -O install.sh ${repo_url}systools/install.sh && chmod +x install.sh && ./install.sh $softwareName
    fi
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
    option 1 "Sudo" 
    option 2 "Vim"
    option 3 "Tar"
    option 4 "Zstd"
    option 5 "Git"
    option 6 "Lsof"
    option 100 "DIY"
    green " =================================================="
    option 0 "退出脚本"
    echo
    read -p " 请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           sudo
        ;;
        2 )
           vim
        ;;
        3 )
           tar
        ;;
        4 )
           zstd
        ;;
        5 )
           git
        ;;
        6 )
           lsof
        ;;
        100 )
           diy
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
