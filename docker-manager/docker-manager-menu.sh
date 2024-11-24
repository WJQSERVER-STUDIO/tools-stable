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

#Docker一键安装&更新
function docker-install(){
    wget -O docker-install.sh ${repo_url}docker-manager/docker-install.sh && chmod +x docker-install.sh && ./docker-install.sh
}

#查看Docker状态
function docker-info(){
    wget -O docker-info.sh ${repo_url}docker-manager/docker-info.sh && chmod +x docker-info.sh && ./docker-info.sh
}

#Docker容器资源占用查看
function docker-container-stats(){
    docker stats
}

#Docker容器管理
function docker-container(){
    wget -O docker-container.sh ${repo_url}docker-manager/docker-container.sh && chmod +x docker-container.sh && ./docker-container.sh
}

#Docker镜像管理
function docker-image(){
    wget -O docker-image.sh ${repo_url}docker-manager/docker-image.sh && chmod +x docker-image.sh && ./docker-image.sh
}

#Docker网络管理
function docker-network(){
    wget -O docker-network.sh ${repo_url}docker-manager/docker-network.sh && chmod +x docker-network.sh && ./docker-network.sh
}

#Docker卷管理
function docker-volume(){
    wget -O docker-volume.sh ${repo_url}docker-manager/docker-volume.sh && chmod +x docker-volume.sh && ./docker-volume.sh
}

#清理未使用Docker资源
function docker-rm-unused(){
    wget -O docker-rm-unused.sh ${repo_url}docker-manager/docker-rm-unused.sh && chmod +x docker-rm-unused.sh && ./docker-rm-unused.sh
}

#Docker一键卸载
function docker-remove(){
    wget -O docker-remove.sh ${repo_url}docker-manager/docker-remove.sh && chmod +x docker-remove.sh && ./docker-remove.sh
}

#Docker安装脚本(trixie优化)
function docker-install-trixie(){
    wget -O docker-install-trixie.sh ${repo_url}docker-manager/docker-install-trixie.sh && chmod +x docker-install-trixie.sh && ./docker-install-trixie.sh
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
    option 1 "Docker一键安装&更新"
    option 2 "查看Docker状态"
    option 3 "Docker容器资源占用查看"
    green " =================================================="
    option 4 "Docker容器管理"
    option 5 "Docker镜像管理"
    option 6 "Docker网络管理"
    option 7 "Docker卷管理"
    green " =================================================="
    option 8 "清理未使用Docker资源"
    option 9 "Docker一键卸载"
    green " =================================================="
    option 13 "Docker安装脚本(trixie优化)"
    green " =================================================="
    option 0 "退出脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           docker-install
        ;;
        2 )
           docker-info
        ;;
        3 )
           docker-container-stats
        ;;
        4 )
           docker-container
        ;;
        5 )
           docker-image
        ;;
        6 )
           docker-network
        ;;
        7 )
           docker-volume
        ;;
        8 )
           docker-rm-unused
        ;;   
        9 )
           docker-remove
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
