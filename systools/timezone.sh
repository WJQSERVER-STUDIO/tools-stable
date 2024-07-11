#!/bin/bash

mikublue="\033[38;2;57;197;187m"
yellow='\033[33m'
white='\033[0m'
green='\033[0;32m'
blue='\033[0;34m'
red='\033[31m'
gray='\e[37m'

change_timezone() {
    local timezone=$1

    # 检查时区是否存在
    if [[ ! -e "/usr/share/zoneinfo/$timezone" ]]; then
        echo "无效的时区：$timezone"
        exit 1
    fi

    # 创建时区符号链接
    sudo ln -sf "/usr/share/zoneinfo/$timezone" /etc/localtime

    # 更新系统时间
    sudo hwclock --systohc

    echo "系统时区已成功修改为：$timezone"
}

# 显示常见时区选项
clear
echo "常见时区选项："
echo "1. 亚洲/上海 (UTC+8)"
echo "2. 亚洲/香港 (UTC+8)"
echo "3. 亚洲/台北 (UTC+8)"
echo "4. 亚洲/东京 (UTC+9)"
echo "5. 亚洲/首尔 (UTC+9)"
echo "6. 亚洲/新加坡 (UTC+8)"
echo "7. 澳大利亚/悉尼 (UTC+10)"
echo "8. 欧洲/伦敦 (UTC+0)"
echo "9. 美洲/纽约 (UTC-5)"
echo "10. 更多时区"

read -p "请选择时区（1-10）： " option

case $option in
    1) timezone="Asia/Shanghai";;
    2) timezone="Asia/Hong_Kong";;
    3) timezone="Asia/Taipei";;
    4) timezone="Asia/Tokyo";;
    5) timezone="Asia/Seoul";;
    6) timezone="Asia/Singapore";;
    7) timezone="Australia/Sydney";;
    8) timezone="Europe/London";;
    9) timezone="America/New_York";;
    10) 
        clear
        echo "请选择大洲："
        echo "1. 亚洲"
        echo "2. 美洲"
        echo "3. 欧洲"
        echo "4. 非洲"
        echo "5. 澳大利亚"
        read -p "请输入大洲编号： " continent
        case $continent in
            1) 
                clear
                echo "亚洲时区选项："
                echo "1. 亚洲/上海 (UTC+8)"
                echo "2. 亚洲/香港 (UTC+8)"
                echo "3. 亚洲/台北 (UTC+8)"
                echo "4. 亚洲/东京 (UTC+9)"
                echo "5. 亚洲/首尔 (UTC+9)"
                echo "6. 亚洲/新加坡 (UTC+8)"
                echo "7. 亚洲/澳门 (UTC+8)"
                read -p "请输入亚洲时区编号： " asia_option
                case $asia_option in
                    1) timezone="Asia/Shanghai";;
                    2) timezone="Asia/Hong_Kong";;
                    3) timezone="Asia/Taipei";;
                    4) timezone="Asia/Tokyo";;
                    5) timezone="Asia/Seoul";;
                    6) timezone="Asia/Singapore";;
                    7) timezone="Asia/Macao";;
                    *) echo "无效的选项"; exit 1;;
                esac
            ;;
            2) 
                clear
                echo "美洲时区选项："
                echo "1. 美洲/纽约 (UTC-5)"
                echo "2. 美洲/洛杉矶 (UTC-8)"
                echo "3. 美洲/迈阿密 (UTC-5)"
                read -p "请输入美洲时区编号： " america_option
                case $america_option in
                    1) timezone="America/New_York";;
                    2) timezone="America/Los_Angeles";;
                    3) timezone="America/Miami";;
                    *) echo "无效的选项"; exit 1;;
                esac
            ;;
            3) 
                clear
                echo "欧洲时区选项："
                echo "1. 欧洲/伦敦 (UTC+0)"
                echo "2. 欧洲/柏林 (UTC+1)"
                echo "3. 欧洲/巴黎 (UTC+1)"
                echo "4. 欧洲/罗马 (UTC+1)"
                echo "5. 欧洲/莫斯科 (UTC+3)"
                read -p "请输入欧洲时区编号： " europe_option
                case $europe_option in
                    1) timezone="Europe/London";;
                    2) timezone="Europe/Berlin";;
                    3) timezone="Europe/Paris";;
                    4) timezone="Europe/Rome";;
                    5) timezone="Europe/Moscow";;
                    *) echo "无效的选项"; exit 1;;
                esac
            ;;
            4) 
                clear
                echo "非洲时区选项："
                echo "1. 非洲/约翰内斯堡 (UTC+2)"
                read -p "请输入非洲时区编号： " africa_option
                case $africa_option in
                    1) timezone="Africa/Johannesburg";;
                    *) echo "无效的选项"; exit 1;;
                esac
            ;;
            5) 
                clear
                echo "澳大利亚时区选项："
                echo "1. 澳大利亚/悉尼 (UTC+10)"
                echo "2. 澳大利亚/ 墨尔本 (UTC+10)"
                echo "3. 澳大利亚/伯斯 (UTC+8)"
                read -p "请输入澳大利亚时区编号： " australia_option
                case $australia_option in
                    1) timezone="Australia/Sydney";;
                    2) timezone="Australia/Melbourne";;
                    3) timezone="Australia/Perth";;
                    *) echo "无效的选项"; exit 1;;
                esac
            ;;
            *) echo "无效的选项"; exit 1;;
        esac
    ;;
    *) echo "无效的选项"; exit 1;;
esac

# 修改时区
change_timezone "$timezone"

# 回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

# 等待1s
sleep 1

# 返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O systools-menu.sh ${repo_url}systools/systools-menu.sh && chmod +x systools-menu.sh && ./systools-menu.sh
else
    echo "脚本结束"
fi