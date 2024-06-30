#! /bin/bash
# By WJQSERVER-STUDIO
#https://github.com/WJQSERVER-STUDIO/tools-stable


mikublue="\033[38;2;57;197;187m"
yellow='\033[33m'
white='\033[0m'
green='\033[0;32m'
blue='\033[0;34m'
red='\033[31m'
gray='\e[37m'

clear

# 显示免责声明
echo -e "${yellow}免责声明：请阅读并同意以下条款才能继续使用本脚本。"
echo -e "${mikublue}本脚本仅供学习和参考使用，作者不对其完整性、准确性或实用性做出任何保证。"
echo -e "${mikublue}使用本脚本所造成的任何损失或损害，作者不承担任何责任。"
echo -e "${mikublue}不提供/保证任何功能的可用性，安全性，有效性，合法性"
echo -e "${mikublue}当前版本为${red}V.0.9${white}"

sleep 1

repo_url="https://gh.1888866.xyz/https://raw.githubusercontent.com/WJQSERVER-STUDIO/tools-stable/main/"
echo "repo_url=$repo_url" > "repo_url.conf"

# 导入配置文件
source "repo_url.conf"

# 显示确认提示
read -p "$(echo -e "${mikublue}您是否同意上述免责声明?${white}（${green}y${white}/${red}n${white}）: ${white}")" confirm

# 处理确认输入
if [[ $confirm != [Yy] ]]; then
    echo "您必须同意免责声明才能继续使用本脚本。"
    exit 1
fi

read -p "$(echo -e "${mikublue}是否需要安装常用依赖? ${white}(${green}y${white}/${red}n${white}): ${white}")" choice

if [[ "$choice" == "Y" || "$choice" == "y" ]]; then
    #安装依赖
    wget -O install_dependency.sh ${repo_url}install_dependency.sh && chmod +x install_dependency.sh && clear && ./install_dependency.sh

elif [[ "$choice" == "N" || "$choice" == "n" ]]; then
    #主脚本
    wget -O main.sh ${repo_url}main.sh && chmod +x main.sh && clear && ./main.sh
else
    echo "无效的输入"
fi
