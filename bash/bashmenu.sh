#! /bin/bash
# By WJQSERVER-STUDIO_WJQSERVER
#https://github.com/WJQSERVER/tools-stable

clear

mikublue="\033[38;2;57;197;187m"
yellow='\033[33m'
white='\033[0m'
green='\033[0;32m'
blue='\033[0;34m'
red='\033[31m'
gray='\e[37m'

# 显示免责声明
echo -e "${red}免责声明：${mikublue}请阅读并同意以下条款才能继续使用WJQserver-Studio的工具箱"
echo -e "${yellow}===================================================================="
echo -e "${mikublue}本脚本仅供学习和参考使用，作者不对其完整性、准确性或实用性做出任何保证。"
echo -e "${mikublue}使用本脚本所造成的任何损失或损害，作者不承担任何责任。"
echo -e "${mikublue}不提供/保证任何功能的可用性，安全性，有效性，合法性"
echo -e "${yellow}===================================================================="

# 导入配置文件
source "repo_url.conf"

# 显示确认提示
read -p "$(echo -e "${mikublue}您是否同意上述免责声明?${white}（${green}y${white}/${red}n${white}）: ${white}")" confirm

# 处理确认输入
if [[ $confirm != [Yy] ]]; then
    echo "您必须同意免责声明才能继续使用本程序。"
    exit 1
fi

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

#SKY-BOX
function skybox(){
wget -O box.sh https://raw.githubusercontent.com/BlueSkyXN/SKY-BOX/main/box.sh && chmod +x box.sh && clear && ./box.sh
}

#科技Lion
function kejilion(){
curl -sS -O https://raw.githubusercontent.com/kejilion/sh/main/kejilion.sh && chmod +x kejilion.sh && ./kejilion.sh
}

#PVE系统工具3
function pve-source(){
wget -q -O /root/pve_source.tar.gz 'https://bbs.x86pi.cn/file/topic/2023-11-28/file/01ac88d7d2b840cb88c15cb5e19d4305b2.gz' && tar zxvf /root/pve_source.tar.gz && /root/./pve_source
}

#PVE信息补充4
function pve-info(){
wget -O pve-info.sh ${repo_url}bash/pve-info.sh && chmod +x pve-info.sh && ./pve-info.sh
}

#一键配置环境
function aek971(){
    wget -O aek971.sh https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/bash/aek971.sh && chmod +x aek971.sh && ./aek971.sh
}

#一键配置环境
function m320(){
    wget -O m320.sh https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/bash/m320.sh && chmod +x m320.sh && ./m320.sh
}

#返回主脚本
function back(){
    wget -O main.sh ${repo_url}main.sh && chmod +x main.sh && ./main.sh
}

#主菜单
function start_menu(){
    clear
    yellow " WJQserver Studio的快捷工具箱 BETA版 "
    green " WJQserver Studio tools BETA" 
    yellow " FROM: https://github.com/WJQSERVER/tools-dev "
    green " USE:  wget -O tools.sh ${repo_url}tools.sh && chmod +x tools.sh && clear && ./tools.sh "
    red " 本脚本仅用于链接到其他作者的脚本，不做任何保证 "
    yellow " =================================================="
    green " 1. SKY-BOX_BlueSkyXN综合工具箱" 
    green " 2. 科技Lion工具箱·"
    green " 3. PVE-source(by Jazz)"
    green " 4. PVE信息补充" 
    green " 5. WJQserver Studio边缘节点一键部署"
    green " 6. WJQserver Studio边缘节点一键部署(无DOCKER)"
    yellow " =================================================="
    green " 0. 返回主界面"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           skybox
	    ;;
        2 )
	       kejilion
        ;;
	    3 )
           pve-source
	    ;;
        4 )
	       pve-info
        ;;
	    5 )
           aek971
	    ;;
        6 )
	       m320
        ;;
	    7 )
           web
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
