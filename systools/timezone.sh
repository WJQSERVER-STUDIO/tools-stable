#!/bin/bash

# 函数：修改系统时区
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
echo "常见时区选项："
echo "1. 亚洲/上海"
echo "2. 美洲/纽约"
echo "3. 欧洲/伦敦"
echo "4. 澳大利亚/悉尼"
echo "5. 亚洲/香港"
echo "0. 自定义时区"

# 提示用户选择时区
read -p "请选择时区（1-5）： " option

case $option in
    1)
        timezone="Asia/Shanghai"
        ;;
    2)
        timezone="America/New_York"
        ;;
    3)
        timezone="Europe/London"
        ;;
    4)
        timezone="Australia/Sydney"
        ;;
    5)
        timezone="Asia/Hong_Kong"    
    0)
        read -p "请输入自定义时区： " custom_timezone
        timezone=$custom_timezone
        ;;
    *)
        echo "无效的选项"
        exit 1
        ;;
esac

# 修改时区
change_timezone "$timezone"


#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O systools-menu.sh ${repo_url}systools/systools-menu.sh && chmod +x systools-menu.sh && ./systools-menu.sh
else
    echo "脚本结束"
fi
