#! /bin/bash

apt install fail2ban -y
systemctl enable fail2ban
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
rm -rf /etc/fail2ban/jail.d/*
wget -O /etc/fail2ban/jail.d/sshd.local https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/systools/firewall/fail2ban/sshd.local
systemctl restart fail2ban

echo "fail2ban安装完成,已开启SSH防爆破"

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    echo "wget -O firewall_menu.sh ${repo_url}systools/firewall/firewall_menu.sh && chmod +x firewall_menu.sh && ./firewall_menu.sh"
else
    echo "脚本结束"
fi