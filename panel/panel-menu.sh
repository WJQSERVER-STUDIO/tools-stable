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

#1Panel面板
function 1panel(){
curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh -o quick_start.sh && sudo bash quick_start.sh
}

#宝塔面板
function btpanel(){
if [ -f /usr/bin/curl ];then curl -sSO https://download.bt.cn/install/install_panel.sh;else wget -O install_panel.sh https://download.bt.cn/install/install_panel.sh;fi;bash install_panel.sh ed8484bec
}

#aaPanel面板
function aapanel(){
if [ -f /etc/os-release ]; then
    # 从os-release文件中获取发行版信息
    source /etc/os-release
    if [[ $ID == "centos" ]]; then
        echo "CentOS"
        yum install -y wget && wget -O install.sh http://www.aapanel.com/script/install_6.0_en.sh && bash install.sh aapanel
    elif [[ $ID == "ubuntu" || $ID == "deepin" ]]; then
        echo "Ubuntu/Deepin"
        wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && sudo bash install.sh aapanel
    elif [[ $ID == "debian" ]]; then
        echo "Debian"
        wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && bash install.sh aapanel
    else
        echo "不支持的发行版"
    fi
else
    echo "无法确定是否支持此发行版"
fi
}

#CasaOS面板
function casaos(){
curl -fsSL https://get.casaos.io | sudo bash
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
    yellow " =================================================="
    green " 1. 1Panel面板" 
    green " 2. 宝塔面板"
    green " 3. aaPanel面板(宝塔国际版)"
    green " 4. CasaOS面板" 
    yellow " =================================================="
    green " 0. 返回主脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           1panel
	    ;;
        2 )
	       btpanel
        ;;
	    3 )
           aapanel
	    ;;
        4 )
	       casaos
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
