#!/bin/bash

mikublue="\033[38;2;57;197;187m"
yellow='\033[33m'
white='\033[0m'
green='\033[0;32m'
blue='\033[0;34m'
red='\033[31m'
gray='\e[37m'

apt install ethtool -y

# 获取本地网络信息
interface=$(ip -o -4 route show to default | awk '{print $5}')
local_ipv4=$(ip -4 addr show dev $interface | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
local_ipv6=$(ip -6 addr show dev $interface | grep -oP '(?<=inet6\s)[\da-fA-F:]+')
gateway=$(ip route | grep default | awk '{print $3}')
subnet_mask=$(ip -4 addr show dev $interface | grep -oP '(?<=inet\s)\d+(\.\d+){3}/\d+')
dns_servers=$(awk '/^nameserver/ {print $2}' /etc/resolv.conf)
model=$(ethtool -i $interface | awk '/^driver:/ {print $2}')
speed=$(ethtool $interface | awk '/Speed:/ {print $2}')
duplex=$(ethtool $interface | awk '/Duplex:/ {print $2}')

# 获取公网IP
public_ipv4=$(curl 4.ipw.cn )
public_ipv6=$(curl 6.ipw.cn )

# 输出结果
echo "本地网络信息："
echo -e "${yellow}==================================================${white}"
echo -e "${mikublue}接口名称:${white} $interface"
echo -e "${mikublue}IPv4地址:${white} $local_ipv4"
echo -e "${mikublue}IPv6地址:${white}"
echo -e "$local_ipv6"
echo -e "${mikublue}网关:${white}     $gateway"
echo -e "${mikublue}子网掩码:${white} $subnet_mask"
echo -e "${mikublue}DNS服务器:${white}"
echo -e "$dns_servers"
echo -e "${mikublue}公网IPv4地址:${white} $public_ipv4"
echo -e "${mikublue}公网IPv6地址:${white} $public_ipv6"
echo -e "${mikublue}网卡型号:${white} $model"
echo -e "${mikublue}网卡速率:${white} $speed"
echo -e "${mikublue}双工状态:${white} $duplex"
echo -e "${mikublue}链路状态:${white} $(ip link show dev $interface | awk '/state/ {print $9}')"
echo -e "${yellow}==================================================${white}"

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