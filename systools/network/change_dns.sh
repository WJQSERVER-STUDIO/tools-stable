#!/bin/bash

# 提示用户选择操作
echo "请选择要执行的操作："
echo "1. 更换DNS服务器"
echo "2. 还原备份的DNS文件"
read -p "请输入选项： " option

if [[ $option == "1" ]]; then
    # 更换DNS服务器

    # 提示用户输入要更换的DNS服务器
    read -p "请输入要更换的DNS服务器IP地址: " new_dns_server

    # 检查用户输入的DNS服务器地址格式
    if [[ ! $new_dns_server =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "无效的DNS服务器地址！请确保输入的是正确的IPv4地址。"
        exit 1
    fi

    # 备份当前的resolv.conf文件
    cp /etc/resolv.conf /etc/resolv.conf.bak

    # 删除旧的nameserver行
    sed -i '/^nameserver/d' /etc/resolv.conf

    # 添加新的nameserver行
    echo "nameserver $new_dns_server" >> /etc/resolv.conf

    echo "DNS已成功更改为 $new_dns_server"
elif [[ $option == "2" ]]; then
    # 还原备份的DNS文件
    
    # 检查是否存在备份的DNS文件
    if [[ ! -f /etc/resolv.conf.bak ]]; then
        echo "没有找到备份的DNS文件！无法还原。"
        exit 1
    fi

    # 还原备份的DNS文件
    cp /etc/resolv.conf.bak /etc/resolv.conf

    echo "DNS文件已成功还原为备份文件"
else
    echo "无效的选项！"
    exit 1
fi

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O network_menu.sh ${repo_url}systools/network/network_menu.sh && chmod +x network_menu.sh && ./network_menu.sh
else
    echo "脚本结束"
fi
